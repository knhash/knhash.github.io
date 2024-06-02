---
published: false
layout: post
title:  "Exploring Lookalike"
subtitle: "Sparse User Personalization via Lookalike Clustering: A Cold-Start Solution"
date:   '2024-06-01 11:11:11 +0530'
tags:
  - general
  - recommendation-systems
---

- by Shashank and Ritika

> "What does Instagram do? It tries to understand what I like and keeps giving me that. Sometimes it adds new content in between to test if I like it or not, otherwise it keeps giving me content that I have liked in the past."

Recommendation systems consist of three components: a) User pool, b) Item pool, and c) Interactions. The general gist of the system is to recommend items to the users that they might like, typically using the interactions of the users. 

What about the users who have not interacted yet, who are just dipping their toes into the platform or just haven't gotten active enough to learn anything from their behavior? These users are called cold and sparse users. They're like the new kids on the block, and traditional recommendation systems often struggle to figure out what they might like because, well, they don't have much to go on.

Enter **Lookalike Modelling**. It's kind of like when you meet someone new and realize they have similar tastes and interests as your best friend. Lookalike modeling works on the same principle – finding users who share similarities in behavior and preferences to make predictions about what they might enjoy.

The hypothesis is two-fold:
- one, the users are not _that_ unique, and their characteristics can be grouped together by their attributes. 
- two, the users of a local group, when given a treatment, react in a similar fashion.

If both of them hold true then we could find "similar" dense users to our cold-sparse users, apply _their_ treatment to the sparse users, and we should see more engagement. Success!

## Step 1 - Analysis

For those new to recommender systems, you'll want to start by following the [guide to recommender systems in production](https://knhash.in/blog/recommender-system-in-prod).

First, some analysis. We need to do some setup before we can even think about deploying this model (always keep the hypotheses in mind). The following will be key steps along the way:

- Fetch and clean user metadata for our dense users.
- Cluster the user metadata.
    - What algorithm to choose here? Start simple with k-means.
    - How many clusters to choose?
- Analyze the clusters.
    - Identify and evaluate the user personas coming out of the clusters.
- Correlate with the user behavior.
    - Within a cluster, the behavior should be similar; across the clusters, the behavior should be different.
    - How to define behavior? Let's call it how they react to content, and quantize it somehow.

Once the analysis comes through we have a good amount of confidence in the methodology, until hypothesis one. We will cover some key waypoints along the way.

The user metadata we had consisted of the following: 

#### Demographic Information
- *Gender of the User:* This feature captures the predicted gender of the user, likely inferred from other demographic or behavioral data. It's a binary variable, indicating male or female.

- *Tier of the City:* This categorical variable represents the tier of the city in which the user resides. It could have values such as Tier 1, Tier 2, Tier 3, etc., providing insights into the user's geographical location and potentially socio-economic status.

#### Device Specifications
- *Price of the Android Phone:* This continuous variable denotes the price range of the Android phone used by the user. It provides insights into the user's purchasing power and preferences regarding device affordability.

- *DPI (Dots Per Inch):* This continuous variable represents the screen resolution of the Android phone. It indicates the level of display quality and may influence the user's viewing experience and interaction behavior.

#### Category Preference Information
- *Category Preference Vector:* This feature captures the user's preferences across different content categories. It's represented as an 18-dimensional vector, where each dimension corresponds to a specific content category. This came out of a pretty detailed onboarding process.

Some feature engineering considerations:

- *Derived Features:* Gender may be a derived feature inferred from other user characteristics or behavior.
- *One-Hot Encoding:* Categorical variables like gender and tier of the city may be encoded using one-hot encoding to convert them into a format suitable for analysis.
- *Normalization:* Continuous variables like price and DPI may be normalized to ensure that they are on a comparable scale and do not disproportionately influence the clustering process.

Given the sparse and high-dimensional nature of the feature space, dimensionality reduction becomes crucial for meaningful clustering. Singular Value Decomposition (SVD) is employed to reduce the dimensionality of the data while preserving its essential structure. 

Identifying the optimal number of clusters is a critical step in clustering analysis. We employ the elbow method for K-Means Clustering, plotting the Within-Cluster Sum of Square (WCSS) against the number of clusters. The elbow point indicates the optimal number of clusters, balancing the trade-off between model complexity and clustering quality.

Keep in mind all of these simple first steps. Each step can be individually iterated upon to gain disproportionate advantages later on. Which means, more features, better encoding, different clustering algorithms, and better tuning.

Lucky for us the first few steps already bore fruit. On looking at the attributes of the clusters, we could make out some distinct and meaningful "personas" out of the users - now all that is left is to see if the clusters correlate with the user's behaviors.

| Cluster | DPI       | Tier      | Gender        | Price  | Preference Categories (ordered by priority)               |
|---------|-----------|-----------|---------------|--------|-----------------------------------------------------------|
| 0       | High      | Mix       | Male          | Mix    | Finance, Productivity, Entertainment                     |
| 1       | High      | T1/T3  | Male | Mix    | Shopping, Finance, Business, Social                       |
| 2       | High      | Mix       | Male | Middle | Finance, Social                                           |
| 3       | Very Low  | Mix       | Mix           | Low    | Finance, Social, Entertainment                            |
| 4       | Low       | Mix       | Mix           | Middle | Social, Entertainment, Finance, Shopping                  |
| 5       | Very High | Mix       | Mix           | High   | Shopping, Finance, Entertainment, Productivity           |

Calculate interaction scores for users within each cluster over a defined period, such as a 30-day window. Interaction scores can be based on various engagement metrics, such as dwell time, clicks, likes, shares, or any other relevant user actions.

Aggregate the interaction scores of users within each cluster to obtain cluster-level interaction patterns. This involves calculating the mean or median interaction scores for each content category across all users within the cluster.

Create visualizations, such as heatmaps or matrices, to represent the relationship between clusters and content categories based on their interaction scores. Each cell in the heatmap or matrix corresponds to a cluster-content category pair, with the color intensity indicating the strength of interaction.

For example, the following is the median matrix for the interaction scores of users within each cluster for each content category. This provides an overview of how clusters differ in their engagement with different types of content.

![Median Interaction Score Matrix along Categories](/media/explore-lookalike/median_weight_matrix.jpg)

## Step 2 - Productionizing

How do we get from here to ranking content for the users? It is time to talk treatment.

Dense users have models running for them that leverage their interactions to personalize content better. We could use one of the models' output prediction patterns. A typical way to do this would be:

- Find the cluster that a sparse user, A, belongs to; call it X.
- Find the dense user at the center of the cluster, c(X) = Y.
- Find the predictions we are going to send for the dense user, P(Y).
- Send _these_ predictions to the sparse user, P(A) -> P(Y).

These predictions would need to run for the (one) dense user in real-time multiple times, i.e., whenever the sparse users request predictions. If the input conditions don't change for the dense user, then we can save the dense user weights in a low-latency cache and use it through the period until the input conditions change.

The models we had in production at the time were user-level logistic regression models. But keep in mind any model would work here. We only need to save the model predictions for some explicit pivotal users.

The model we ended up using was actually a multi-armed bandits (MAB) model. The user weight would be the weights associated with individual category arms. This ensured a semblance of exploration and discovery while we serve the predictions instead of having a frozen recommendation set. The MAB would identify the slots, here categories, we need. And depending on the category, we would fill the slots with either popularity or recency-ranked items of that category. Some categories work better with recency, like news, while others work better with popularity, like fashion - this we had established as part of a prior analysis.

![System Design](/media/explore-lookalike/arch.jpeg)

## Step 3 - Experimentation and Iterations

#### Performance Metrics
- **Time Spent:** The clustering-based recommendation system showed a significant improvement in average time spent by users compared to the baseline model, referred to as Pacing. On average, there was an 11.68% increase in time spent.

- **Reward Rate:** The clustering-based system outperformed Pacing, showing a 4.5% increase in reward rate on average.

#### Performance on Cold Users
- **Cold Users:** The system showed an average lift of 18.38% in time spent and 5.76% in reward rate compared to the Pacing model for this user cohort.

The results of the A/B experiment demonstrate the effectiveness of the clustering-based recommendation system in improving user engagement and interaction rates. The next steps were to dig into the various levers and try to eke out more wins. But this, as it stands, is in itself a success.

So we wrote a paper about it :)

[Read it here](https://github.com/knhash/ExploreLookalike/blob/5c758cc55169321d5d3b51ae16aa5809a3483ac4/Explore_Lookalike.pdf). It has more details and insights within.

If you want to talk more about it, please contact [me](email:contact@knhash.in) or [Ritika](email:ritikakumari1302@gmail.com).

Cheers.