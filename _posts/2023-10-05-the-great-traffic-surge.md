---
published: true
layout: post
date: '2023-10-05 17:00:00 +0530'
tags:
  - general
  - recommendation-systems
title: >-
  The Great Traffic Surge
subtitle: A Machine Learning Engineer's Tale of Resource Starvation and Memory Limits
---
You log in and see that one of your prediction service endpoints has been throwing errors since a few hours, **HTTP 503**, the server is currently unavailable. The *on-call* has taken down the model and deployed a fallback - so as to not trip the engineering circuit breakers anymore.

You are the model owner. You have to fix the issue on priority.

This is an at scale model, operating on a daily active user base of about **25 million**.

> Welcome to *(the start of)* a day in the life of a Machine Learning Engineer.

----

### Background


At Glance we build a feed of personalized content for users. Not unlike Reels or TikTok. We have a prediction service, a REST endpoint, which serves the recommendations for the users. In this particular case this one endpoint was responsible for a traffic of around 12,000 requests per second. On a typical day this endpoint would have a latency well under 100ms. It had an auto-scaling policy enabled to account for the cyclical nature of the traffic pattern.

Today, was not a typical day.

### Let’s start


The first two messages on Teams were from 


- OpsGenie, alerting me on the outage, escalated already.
- The on-call pinging me about the outage, the fix they have put in place as a temporary message.

Clicking on the link to the message led to the monitoring dashboard for this particular endpoint.

![image]({{site.baseurl}}/media/FirstView.png)

Not good. ~100% error rate, at over 25k RPS.

Increasing the time window tells us exactly when the failure started:

![image]({{site.baseurl}}/media/SecondLook.png)

Sometime just before six the traffic increased steeply, and almost immediately the errors went to 100%. *The drastic increase in traffic seems to be the culprit*. But the outage has carried on, even during the times when traffic was similar to the previous day. Notice the RPS around 7 AM is not dissimilar to the traffic around 6 PM of the previous night. 0% errors then, 100% errors now? And from the previous graph, all of them were HTTP 503, server not found. 

> Why were the servers not found, when they were found yesterday… 


All this while the latencies are *through the roof.*

![image]({{site.baseurl}}/media/RooftopLatencies.png)

### Resource utilization


So the servers are not available. The first graph under Resource Utilization is this:

![image]({{site.baseurl}}/media/ResUtilFirst.png)

Interesting. We need 21 nodes to service the traffic right now but are only able to maintain 5-7. We are not able to bring up the servers. Increasing the time window we see that yes, indeed around 0600, when the errors shot up to 100%, *when the traffic spiked up swiftly*, the resource starvation started. Notice the two lines almost overlapping before, but diverging during the outage:

![image]({{site.baseurl}}/media/ResUtilSecond.png)

The configuration is setup to go as high as 80 nodes (technically 100 if you are keen eyed), but something is preventing it from even hitting 20 nodes.

The CPU usage graph is …. a mess. Looks like the nodes are getting killed constantly. And they are getting killed around 350%, when they could theoretically go upto 400% (800 less the autoscaling threshold, set to 50%) . You see, we have deployed this on `n1-highcpu-8` nodes. And clearly it has hit 400% before without a hitch.

![image]({{site.baseurl}}/media/CPUUsage.png)

The memory usage paints a similar picture:

![image]({{site.baseurl}}/media/MemUsage.png)

Hey, that is a **very sharp cutoff** in memory! Almost as *if the nodes are hitting some memory limit and getting killed*.

`n1-highcpu-8`, from memory, should have 8GB of memory. A quick lookup told me I was wrong, it is somewhere close to 7GB. Which is still above the seeming cutoff at 5.3GB, so what gives?

> We do not have access to **all** the memory of the node!


Because our systems run within docker containers. The OS, docker daemons and other processes would ofcourse need some memory for themselves. Fair.

But but but, 5.3GB of memory during the outage, and a near constant 3GB usage in the previous day. Huh?

To recap, we know the following:


- ~100% errors; because
- HTTP 503, server currently unavailable; because
- Nodes not coming up and meeting the target replica count; because
- Nodes getting killed due to them running out of memory; because
- **Why?**

### A side note on the graphs

If you noticed in the graphs, all of them start around 5PM the previous day. That is because this model was scaled up to 100% then, and the node configuration was arrived at looking at the peak traffic. As the memory utilization was under 5GB consistently, we moved from `n1-standard-8` nodes, which have 30GB of memory, to `n1-highcpu-8` nodes with 7GB memory. For the cost savings. 

----

### Final strokes, let us finish the puzzle, here’s what happened

- At 0530 in the morning the traffic spiked almost 3x. This was expected and routine, but wasn’t accounted for. 
- The nodes were at a minimum count of 6 during the night.
- The autoscaling kicked in, but was not fast enough
- The nodes that were alive got bombarded with requests, getting put into queues on the device
	- This is what led to the rise in memory usage - the sheer flooding of messages was exhausting memory
- As the nodes ran out of memory the nodes got killed. New ones spawned. But the situation is just worse, so of-course they also got killed.
- The autoscaling policy was set on CPU utilization
	- Therefore the replica target was never going above 21, as far as the autoscler was concerned we did not need more nodes
		- But more nodes would have helped in this case. Sidenote, should we also define an autoscaler on memory?

So a simple redeployment would have sufficed for the time being - a slow canary deployment to move traffic to new nodes. But to account for the 0530 spike we decided to overprovision the buffers slightly, go to `n1-highcpu-16` . 

Tomorrow when the traffic rises, the 6 minimum count nodes should be able to handle the bump until the new nodes spawn up.

Wrapping up with some happy looking graphs. No errors on the 30k RPS, sub-200ms latency.

![image]({{site.baseurl}}/media/FinalOne.png)

![image]({{site.baseurl}}/media/FinalTwo.png)

> *Look ma, I didn't even touch the logs!*
