---
layout: post
title: Let me help you, please
subtitle: ''
date: 2023-01-14T15:30:00.000+00:00
tags:
- recommendation-systems

---
Recommendation systems are hard. Some get it working amazingly well - TikTok - and it becomes a big discussion: what implicit insight did TikTok crack to make it one of the best performing qualitative recommendation systems out there? Tons of papers get published.

At the end of the day the simple mandate is: **give me content I am going to like without me telling you what the content is**. If I tell I like this and you give it me, eh, every roadside shop does it too. I want to walk into a boutique and have a professional eye me critically and give me a dress which I will accept as the best thing ever and be happy.

> I want a mind reader.

Companies do their best to work in these constraints. Asking users the initial preferences to seed recommendations, to alleviate some of the cold-start worries. Using second order signals like subscribing, bookmarking. Asking users to give them explicit signals when they like something - heart, thumbs-up. Bear in mind the mandate is already broken, you are _asking_  users for input. “But we can’t read minds, we need to get inputs from the user!”. TikTok took off because it was the closest to the mandate, using all its data science and design capabilities to get there.

I want to talk about the third point above, about asking people to signal when they like something. Obviously this is a strong and clean signal of user’s preference. But anyone who has worked on recommendation systems will tell you how sparse this signal is in the real world. People just do not want to give out this signal. Why is that?

I propose 2 hypotheses, purely as thought experiments.  It is a funnel, with the top layer being “if I tell you what I want it isn’t magical anymore”. The mandate above. Everyone is operating under that mandate when they use these systems. It is inherently present. Fair. After this layer, where is the further drop off?

### Why do people not tell me what they like?

**1. We still do not like divulging preferences**  
Something about systems knowing our preferences deeply unsettles us, at a visceral level. Other people knowing our preferences, hell no. Not unless it is carefully crafted to fit a social narrative. Preferences are a part of our personality. And we care about how people see us.

Here comes LinkedIn and Facebook which broadcasts everything we do to our network. They liked this article, they shared this post, they connected with this person, they followed this news. Everything we do, broadcasted. And everyone who comes across this forming their own opinions, coloured by their own biases, about us.

The first hypothesis is people don’t like giving out these signals because it also signals their preferences to their network, which they don’t really want to do? I don’t really want my boss to know I like watching cat videos on loop, what if he thinks I am not working as much as I should?

**2. The stupid, greedy recommendation systems**

Here’s a scenario. The first time I had momos I come home and tell my mother about it. Raving about how good it is. She says momos are simple, I could make it for you at home. That doesn’t preclude the fact that momos are amazing. She took it heart (how can he appreciate momos so much and not my biryani?? that is significantly harder to prepare, so much effort - or something along those, I dunno. I am guessing)

Next day she makes momos at home. I like it. Say it is amazing. Then she makes momos the day after again. It took me just two days to get over momos. I went from loving momos to almost gagging at their sight. It was too much!

Just because I tell you I like something doesn’t mean I want to keep doing that immediately and repeatedly. YouTube! Please! Amazon - I bought an oven. Like 2 weeks back. Why are you still recommending ovens to me? You know I have one. I bought it from you!

Once I watched that video. Sure I liked it, but I want to other stuff too man. Or the flip side, I have watched every big content piece of this particular creator, the lifecycle is done. Why are you still showing me pieces “related” to them? I just like the comedian, I have seen all their skits. I don’t want to watch interviews and scandals and what they had for dinner on Golden Globes night, come on.

The second hypothesis is people are afraid of telling their preference to the system because it will go berserk-mom-mode all over them. A weakly held hypothesis, one I think mostly applicable to tech savvy people. Probably a minuscule portion of the overall population. Just the geeks?

But it may not be as minuscule I am thinking. You can _see the effects_  your watch history is having on your feed. Question is, is there cross learning happening in users across platforms? Have users been burnt by past recommendation systems so much that they don’t want to signal likes anymore?

> I think so. Tell me how I can go about verifying this. And how big of a problem this is.

Netflix seems to be onto something with their single thumbs-up, single thumbs-down and double-thumbs-up approach. Almost like saying “_Hey just tell us if you like this, it is extremely useful for us to know. We promise not to force content like this down your throat. Unless you LOVE it. Tell us that and we will know. We are here to help :) ._ ”

***

Part of evening discussions over nachos with [@Ritesh](https://blog.badpallod.com/) 