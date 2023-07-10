---
published: true
title: "[PROJ] Trusted Circle - Tree of brands"
layout: post
date: '2023-07-10 22:30:00 +0530'
tags:
  - general
---

`PART ONE` 

Reviews held the promise of an unbiased pair of eyes competently analysing a product and boiling down the relevant details for a quick preview of the product before you commit to buying it. If a varied many people found the product good, chances are the product _is good_. Good products rise to the top based on reviews. 

You’ll find reviews in many different scenarios. Obviously the detailed write up and video reviews like that of a car or a mechanical keyboard. But also restaurant reviews in a food service aggregator. Product ratings in an e-commerce website. Movie ratings. Right down the recommended neighbourhood tea stall for the best adarak wali chai. 

I am conflating Reviews, Ratings and Recommendations. All three have the same basic core. Recommendations are personal, typically in person `{1 product, from 1 person to 1 person}` . Reviews are detailed thoughts on a product `{1 product, from 1 person to many persons}` . Ratings are condensed reviews by multiple people `{1 product, from many persons to many persons}` . 

Notice a distinct human presence in the system. When we “sort by popular” on any website we are implicitly relying on this human core - a lot of people like it, so it must be good. 

Let’s talk about the problems. 

  

### Aggregation

Attention spans are reducing. We want to know what _a lot of people_ think about something _as fast as possible_. Enter **aggregation**.

Which means boiling it all down to a rating - average. There is a reason why almost all ratings are simple averages, they are simple to understand for the vast majority of people (you don’t want to be spending the precious few initial onboarding seconds on a _whole new rating system_ in your product. Your Product Manager will come after you with a vengeance).

And Averages are a bad representative. For a lot of reasons. Especially on skewed datasets, which ratings typically tend towards. But also, because they are _not representative enough._ Obviously you would trust 4.5 stars from 5000 people more than 4.3 stars from 5000 people. Right? For the most part. But then do you trust 4.5 stars from 5000 people or 4.9 stars from 3000 people? Where  do you draw the line? (Hello philosophical haystack, you follow me around still)

But all 4.5 stars from 5000 people are not built the same. They can mean completely different things based on the **distribution** of the data. Being able to visualise the ratings is key - because it changes your perception, and rightly so. Allow me to introduce you to Statistical Dinosaurs - be extremely wary of them!

> “... wildly different data sets can give similar results ... **Anscombe's Quartet**: four scatterplots which despite being qualitatively different all have the same mean and variance and the same correlation between them ...” 
> 
> [https://blog.revolutionanalytics.com/2017/05/the-datasaurus-dozen.html](https://blog.revolutionanalytics.com/2017/05/the-datasaurus-dozen.html)

A really neat way to augment ratings is to include a measure of confidence in it. One more variable makes it almost an order of magnitude better in terms of a metric than just mean. The standard deviation (or the variance), to see how close the data points are to each other. Note that it is still falling prey to Statistical Dino above, but it is a more wary prey than just mean.

One of the only ranking datasets that I have seen do this is the **Reddit /r/movies Rankings**. Here is the [2023](https://youpoll.me/list/138/ "https://youpoll.me/list/138/") and [All Time](https://youpoll.me/list/4/ "https://youpoll.me/list/4/") links. It has a sortable mean and standard deviation columns, along with a _filter_ to tweak your own thresholds. Best way by far to rank movies and choose one - the only bias being of the sample set of users doing the ratings. 

Which brings us to

### Gaming the system

The bad actors. People who want to pollute the well for the fun of it, or because their incentives from the platform are different from the general consumers. Bots come here. So do review click farms. 

Fake reviews. 

Because **the company** knows you read the reviews. And then it is just another way to advertise the product. 7 people and their dogs found this pleasant on the eyes. You will too!

Leave a 5 star rating and get a 20% discount on your next purchase T&C applied

How do you trust the reviews?


### Motivation

Why do people leave reviews? Have you left a review, anywhere? Now think about how _different_  the people leaving the reviews are from you. How do you trust them?

Take a moment to ponder - the reviews on the e-commerce website that you depend on to gauge the quality of the product, who writes them?

Bear with me, this is no tinfoil hat monologue.  The implicit assumption when you read the reviews is that these people think like you. For instance, you wouldn’t take the recommendation for a fine dining place from a 14 year old. But you would from your colleague or friend. (Are there 14 year olds reading this I wonder, in which case this argument fall flat). If your friends tell you they like something and you should try it, chances are you would. Similar mindsets. 

Or, you trust the reviewers, in their expertise. This could come from a few premises - 

- a niche community around the product 
- a someone known
- a certified expert 

Either way you value their opinion on the matter. 

Neither of these are applicable in the situation where you have to buy a new electric toothbrush on that e-commerce website. 

> “But if it is anonymous online review, I won’t trust the word of one person”

So you rely on wisdom of the crowds. But the crowds can be _dumb._ And the crowds can be made of bots. And the crowds can be diverse. But take a step back, when not made of bots, who is in the crowd? Why is this person taking precious precious time out of their busy life to write a review? The cynic in me cannot seem to fathom a reason why, unless they get something out of it. Pure altruistic looking out for the welfare of a fellow customer? Come on. 

Is it simply the gratification of being noticed? The likes and stars on the reviews signifying the impact they had on the decision making process of another person? The power to make or break a company?

> “If the product is bad I would immediately go and write a review”  

Or a sounding board for your grievances. The companies do depend on the review for their upcoming businesses, so what better way to get them to rectify their misdemeanours than by publicly calling them out? Immediate resolutions. Woah. Such promptness in service. But had to call it out. 4 stars. 

If all it is is a cry for attention, should you be basing your decisions on such a person whose motivations do not align with yours?

> “It is a well-known fact that those people who must want to _review_ are, ipso facto, those least suited to do it... anyone who is capable of getting _their opinions heard_ should on no account be allowed to do the job.”
> 
>  - Douglas Adams (probably)



* * *

`PART TWO` 

## Trust

It all boils down to trust. 

Long long ago, actually not so long ago, the internet was just becoming popular - which was less than 50 years ago today! There were “web sites” cropping up left right and centre. They had “web addresses”. If you knew the web address you could find the site. Nowadays the whole of internet seems to have converged on a handful of websites, with a search engine like Google acting as the gateway. But this was not always the case. 

> Fun fact, Google is barely even an adult at 24 years of age as of 2023. 

The websites that came up provided services of one form or another. To be found, they were listed in directories, very akin to the famous Yellow Pages. So if you wanted a list of plumbers, I would go to the plumbing section and I would find the website plumber advertising their service. Or classifieds - a common place people to advertise their services.

**But what of the websites of fun?**

How do you share that super cool website that you found with your friends and let everybody know about it? You talk about it on _your_ website. So everyone who visits your website knows about the cool stuff that _you_ found when you ”browsed” the web. Your friend, who has different interests, has their own list of cool websites. You also want the world to know about her cool websites, so you link to her website which lists her amazing website discoveries. Congratulations, you just created the first link on the Webring. 

> “… a collection of websites linked together in a circular structure, and usually organized around a specific theme,…”  
> [https://en.m.wikipedia.org/wiki/Webring](https://en.m.wikipedia.org/wiki/Webring)  
> “… mainly viewed as a relic of the early web of the 1990s...”

The early internet was a wild wild place. If you didn’t know your path you would easily get lost. Most of the times this was a new adventure. Sometimes not. Having some trusted friends would be very helpful in these lawless lands. 

So this guy called [Phil](https://en.m.wikipedia.org/wiki/Phil_Zimmermann) introduced this concept of a [Web of Trust](https://en.m.wikipedia.org/wiki/Web_of_trust). Basically, you setup and announce a group of people as people you trust, and they do the same, and so on. So if Sarah trusts Rahul and Rahul trusts Sudha and Sudha trusts Nemo, then Sarah also (somewhat) trusts Nemo. 

> “…will cause the emergence of a decentralized fault-tolerant web of confidence for all…”  
>  - guy called Phil

Notice the resemblance to a social _network_. This is a social network. A friend of a friend is a friend. 

Now, if a friend of a friend happens to be a carpenter, would you not go to her for advice for your cabinet fixtures rather than a stranger who owns the woodworking shop? No seriously, the woodworker is going to be biased to maximise _his_ business right, so how do you trust his words on anything carpentery? Moreover, if this friend happened to use a particular brand of veneer for their cabinets themselves, isn’t that the absolute highest order of endorsement of the said brand?

What if you could leverage such endorsement - reviews from a trusted source. Find the closest people be traversing your network and see what they are using to give direction to your decision. 

Why would your friend of friend (of friend?) tell _you_ his favourite brand of fountain ink pen? What’s his motivation? Pure altruism? Come on. 

No. This friend just happens to have listed down all the brands and products he has used and the ones he’s using now. Because he likes to 1) keep track of things while he 2) discovers new things. You know, like GoodReads. 

> Bamboozle. This whole long article is basically a pitch for the following idea. 



### Tree of Brands 

Imagine an app that can track all the brands you interact with and gives you summary stats. A brand counter. The brands you use for phone, toothpaste, TV, shoes, so on. Like calorie counter. You input the details. No automatic tracking stuff.

**Imagine this with a network:**
You compare with friends what they are using. More importantly, you can search for something you want to buy and get brand recommendations from your network. 

  
_The incentive for the individual user is tracking. People love tracking stuff . Calories, steps, screen time, books read._ 

Best review for a product: people in your circle using it.  

  

### Why will people use:

- “Achievement unlocked” style skill tree construct. Imagine Duolingo ka tree. Fill in all the brands you use in your house. End of year stats. 
- Track preferences changing. For example, you have been using pepsodent for tooth paste for a while now. You want to try Colgate. Track it. Review it. All for yourself. Find your favourite brand. 
- Find your **next** favourite brand by getting recommendations. Search for a new brand with the help of your network. KNN as a service. 
- Get pings when new product categories unlock. Gamification. Get pings when your network requests for recommendations. Come back to the app. - use case similar to letterboxd and series/cinema tracking apps. 
- Input verification. Use computer vision  for brand logo identification. Restrict inputs to 1 per product category per user (one bike, one mobile, etc). This should reduce people spamming random products for achievements.

:)

* * *

Come, let’s build it. It’s going to be fun. I promise.
