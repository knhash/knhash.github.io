---
layout: post
title:  "Intern Log, Day 55"
subtitle: "Final thoughts on a quad-month internship"
date:   2017-12-12 21:21:21 +0530
tags: [general]
---

Everybody knows the worst time to study is during exams. We take any excuse to _not_ study. The semester end exams were in full swing in July. 

### The story starts in July. 

My friend tells me about an opening in BOSCH for an internship position. He has already been placed and they are looking for one more person. Of course I am interested. This should be a good distraction and a great opportunity. 

### Application

I get an email asking for a phone interview. A day is scheduled and I’m setup. Room door closed, phone charged, earphones on. The interviewer is an engineer on the project and gets straight to the point. A bunch of standard technical questions to assess current knowledge, then a few domain specific questions in machine learning. 

Yup, this was a _machine learning internship_. I had just started the industry standard **Machine Learning** course by **Andrew NG**. I had taken **Pattern Recognition** as an elective just that semester. So I was going for the big leagues here with the confidence of a _pro_, knowledge of a _student_ and experience of a _noob_. 

So here we are in the interview and I’m stumped at her _first_ question. ‘What can you tell me about the Naïve based method?’ I ask her to repeat and she does. I have no clue, I’ve never heard of it. The rest of the questions were better, I answered them all. _Python, regression, classification, supervised vs unsupervised_, all was well. 

Then it strikes me, Naïve **_Bayes_**! The absolute first thing we learn in machine learning. I ask her if I can get back to that question. She is gracious enough to oblige. I answer, follow it up with an explanation of the code and she seems satisfied. A few more questions about college schedule and we are done. 

### The wait. 

A week goes by. I get a mail asking for preferred internship dates. Another week with no contact and I ask about my status. She tells me my internship is under processing and I will receive a mail from the HR soon. _Here’s a course link to refer, that’s your stipend, you can start coming to office from 1st of August, and you’ll be officially inducted on the 9th_. A few formalities from the college side and I was set. 

### And so started the four month journey. 

My friend [Jith](http://abhijithc.ml) and I arrived, bright eyed and bushy tailed, on the morning of the first day of the month. We meet our mentor at the gate and she shows us to our office space. We are assigned two **monster computer systems** (more on that later) and handed a bunch of research papers and documentation. Our task for the day is to get to know the work and the systems. That’s our moment of realisation…this is going to be huge. 

> This is a **production grade** **_machine learning_** **application project** in a **multi national corporation**.

Before this we had little to no experience in machine learning projects. Oh we had the theory worked out. We just hadn’t “worked” on it. And so we spent the day playing catch-up to the previous interns. _And the next. And the next_. Then we ask our mentor to come over and explain it to us. 

> Takeaway #1: **Always** ask questions.

We had a lot of doubts. Some valid, most stupid. But all of them helped us understand our work better. She walks us through the three projects we will be looking after. We go through the presentations, the code and the various folders of interest in the systems. We start to get a sense of what’s happening. 

### Folders of interest?

Ah yes. The systems. The monster systems were 32 core, 250 gigabyte ThinkStations. With a few terabytes worth of hard disks. So storage was not the issue. Consequently there were many, many folders. Much redundancy. Plenty of backups. There was great power but little responsibility. It was a mess. 

> Takeaway #2: Follow a **consistent naming convention**. And keep **records** of your work.

We started to keep track of our work and maintained logs. Sometimes detailed, sometimes eccentric. But everyday in the office was logged. And it has helped us on more than one occasion when we wanted to find something. 

> Plus, it’s **fun**, kinda like being astronauts on a mission.

So we settle in. An informal schedule comes into place. We come in every morning, say good morning, and ask for our daily tasks. And we get to work. 

### The work. 

We were responsible for three projects. One was a **_classification_** problem solved using a convolutional neural network, on the system _Charulatha_. (We named our systems on the first day). _Mythreyi_ was running a **_segmentation_** neural network model. The third project was already deployed on the cloud and was getting production ready. Our daily tasks would involve _testing the models on the native systems according the parameters requested, retraining the models with new images, running threshold calculations, preparing and processing input images for further training, handling the server on the cloud, troubleshooting errors found by the test team, gathering new images for the data-set_. The trainings would take a **long time**. Weeks, sometimes _month_ long. So generally our work happened in bursts. Long periods of work followed by long periods of SwarmSim. 

> Takeaway #3: Laziness is **good**. It instils **efficiency**.

We made scripts. A **lot** of them. We had _scripts in place to run tests, scripts to manage input data, scripts to process images, to move batches of images, rename images, and scripts to automate GUI sequences of processing input data_. That was one of the **cool** ones. We would run the script, sit back and watch as the cursor would move around the screen clicking buttons, selecting stuff, typing paths and saving images. Jith wrote a whole article on our scripting adventure, [here](https://medium.com/@abhijith0505/d-r-y-automation-has-you-covered-b470682a65a3). 

The scripts were our secret weapon. We would be able to complete our tasks in one tenth the time it took the previous interns. We managed to complete a long standing dataset cleaning task with a convoluted series of instructions and scripts. Without the scripts though it would have been a _nightmare_. 

### The experience.

But I loved our work. We got all the leeway of an intern and the work of a full timer. We were single handedly (_double handedly?_) responsible for maintaining the whole system. We took our days off. We played our games. But we got our work done, completed our tasks of the day. And it was **fun**. 

> Takeaway #4: Pair programming is like rubber duck debugging but with a **live sentient duck**.

We found bugs. We squashed them. I don’t think we would have been able to do it individually but together, we took care of everything. One particular bug was particularly interesting. To this day we don’t know why it pops up but Jith found a workaround. We ‘_caught_’ the bug. We were able to find the bug as it affected another variable, _put it in a try-catch block and excepted the error_. That was a feat in itself, it took us a long time of staring at the screen and fiddling with the code for Jith to realize that whenever the error cropped up, a particular variable’s value went below 0.01. 

I know, I know, _but come on_. **Catching** a bug is just as important as **squashing** it. 

The last few days were spent in documenting all the work we did. We worked on a paper along with our mentor (_my first research paper_). The next set of interns were trained to take over. We got a coffee mug (**Yay**). We took our certificates and said our goodbyes. 

> Incidentally, our semester exams started the next week, in December. **And I am writing this during _finals week_**.
