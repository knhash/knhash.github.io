---
published: true
layout: post
title:  "Exploring Lookalike"
subtitle: "Sparse User Personalization via Lookalike Clustering: A Cold-Start Solution"
date:   '2024-06-01 11:11:11 +0530'
tags:
  - general
  - recommendation-systems
---

- by Shashank and Ritika

> "Instagram tries to understand what you like and keeps giving you that. Sometimes it throws in new content to see if you like it, but mostly it sticks to what you've liked in the past." 

It's a neat trick, but it works best for active users. What about the folks who are new or just haven't interacted enough? Those are the cold and sparse users."

## The Challenge of Cold and Sparse Users

Recommendation systems typically consist of three components: 
1. **User Pool** 
2. **Item Pool**
3. **Interactions**

These systems recommend items to users based on their past interactions. However, for cold and sparse users who lack sufficient interaction data, traditional recommendation systems struggle to make accurate predictions.

## Lookalike Modeling: A Solution

**Lookalike Modeling** finds users with similar behaviors and preferences to predict content that new or less active users might enjoy. This approach is based on two hypotheses:
1. Users can be grouped by shared characteristics.
2. Users within a group react similarly to certain treatments.

If these hypotheses hold true, we can identify dense (active) users similar to cold-sparse users, apply the treatments used for dense users, and expect increased engagement from sparse users.

## Step 1 - Analysis

For those new to recommender systems, follow the [guide to recommender systems in production](https://knhash.in/blog/recommender-system-in-prod). Before deploying a lookalike model, thorough analysis is necessary:

1. **Fetch and Clean User Metadata**: Gather data on dense users.
2. **Cluster User Metadata**: Use k-means clustering to identify groups.
    - How many clusters to choose?
    - What pre-processing to do here?
3. **Analyze Clusters**: Evaluate user personas within clusters.
4. **Correlate with User Behavior**: Ensure behavior is similar within clusters and different across clusters.
    - How to define behavior? Let's call it how they react to content, and quantize it somehow.

Once the analysis comes through we have a good amount of confidence in the methodology, until hypothesis one. We will cover some key waypoints along the way.

### User Metadata

User metadata includes demographic information, device specifications, and category preferences:

- **Demographic Information**: Gender, city tier.
- **Device Specifications**: Phone price, screen DPI.

The helped in providing insights into the user's geographical location and potentially socio-economic status.
- **Category Preferences**: An 18-dimensional vector from onboarding, where each dimension corresponds to a specific content category.

### Feature Engineering

- **Derived Features**: Gender may be a derived feature inferred from other user characteristics or behavior.
- **One-Hot Encoding**: Convert categorical variables.
- **Normalization**: Scale continuous variables.

### Dimensionality Reduction and Clustering

Use Singular Value Decomposition (SVD) for dimensionality reduction. Employ the elbow method for K-means to determine the optimal number of clusters.

Keep in mind all of these simple first steps. Each step can be individually iterated upon to gain disproportionate advantages later on. Which means, more features, better encoding, different clustering algorithms, and better tuning.


### Cluster Analysis

Clusters reveal distinct user personas. The following table summarizes attributes and preferences:

| Cluster | DPI       | Tier      | Gender        | Price  | Preference Categories (ordered by priority)               |
|---------|-----------|-----------|---------------|--------|-----------------------------------------------------------|
| 0       | High      | Mix       | Male          | Mix    | Finance, Productivity, Entertainment                     |
| 1       | High      | T1/T3     | Male          | Mix    | Shopping, Finance, Business, Social                       |
| 2       | High      | Mix       | Male          | Middle | Finance, Social                                           |
| 3       | Very Low  | Mix       | Mix           | Low    | Finance, Social, Entertainment                            |
| 4       | Low       | Mix       | Mix           | Middle | Social, Entertainment, Finance, Shopping                  |
| 5       | Very High | Mix       | Mix           | High   | Shopping, Finance, Entertainment, Productivity            |

### Interaction Patterns

Calculate interaction scores for users within each cluster, aggregate them, and visualize the data to represent cluster-content category relationships.

![Median Interaction Score Matrix along Categories](/media/explore-lookalike/median_weight_matrix.jpg)

## Step 2 - Taking It Online

To rank content for sparse users:
1. **Identify Cluster**: Determine the cluster a sparse user belongs to.
2. **Find Dense User**: Locate the dense user at the cluster's center.
3. **Predict Content**: Use the dense user's predictions for the sparse user.

This approach uses real-time predictions, caching dense user weights for efficiency. We utilized a multi-armed bandit (MAB) model to provide exploration and discovery within recommendations. The MAB would identify the slots, here categories, we need. And depending on the category, we would fill the slots with either popularity or recency-ranked items of that category. Some categories work better with recency, like news, while others work better with popularity, like fashion - this we had established as part of a prior analysis.

![System Design](/media/explore-lookalike/arch.jpeg)

## Step 3 - Experimentation and Iterations

### Performance Metrics

- **Time Spent**: 11.68% increase compared to the baseline.
- **Reward Rate**: 4.5% increase compared to the baseline.

### Performance on Cold Users

- **Cold Users**: 18.38% increase in time spent and 5.76% increase in reward rate.

These results highlight the effectiveness of the clustering-based recommendation system in improving engagement. Further iterations and optimizations are ongoing, but the initial success is promising.

So we wrote a paper about it :)

For a detailed study, refer to the [paper](https://github.com/knhash/ExploreLookalike/blob/5c758cc55169321d5d3b51ae16aa5809a3483ac4/Explore_Lookalike.pdf).

For more information, contact [me](email:contact@knhash.in) or [Ritika](email:ritikakumari1302@gmail.com).

Cheers.
