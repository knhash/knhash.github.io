---
layout: post
title: I also want to do something with Stable Diffusion
subtitle: But I don't have a powerful GPU
date: 2022-09-04T11:27:00.000+00:00
tags:
- general

---
Stable Diffusion is all the rage right now. If you are even remotely around the scene of AI and ML you have heard of Stable Diffusion. Rightfully so, [Stable Diffusion is a big deal](https://simonwillison.net/2022/Aug/29/stable-diffusion/ "Stable Diffusion is a big deal"), majorly because they released the weights of the model. Everyone and their manager wants to get onboard this new development in the crux of Art and AI.

I too wanna. Problem is, you still need some fairly powerful GPUs to run the model. Granted the development is happening at a blistering pace (not exaggerating at all, people were able to [bring down GPU requirements](https://constant.meiring.nz/playing/2022/08/04/playing-with-stable-diffusion.html "bring down GPU requirements") and [get it running on M1 Macs](https://replicate.com/blog/run-stable-diffusion-on-m1-mac "get it running on M1 Macs") within a couple weeks!), _but I want to do something now_!

> I like the shoulders of giants - in fact I think some of my best work has been on top of shoulders of giants. It is comfortable to climb onto, has a very solid foundation to build on, and I can see a little bit farther, faster.

So I shall build on top of the shoulders of giants.

#### I built a toy pictionary game, with Stable Diffusion providing the artistic flair

If you are _already excited to check it out_, I call it **diffAKI**, and you can find it here: [https://diffaki.knhash.in](https://diffaki.knhash.in/ "https://diffaki.knhash.in/")

There is this ultra epic site that has a bunch of artworks and prompts very neatly organized called [Lexica.Art](https://lexica.art "Lexica.Art"). I picked up the API from it to generate random prompt-image pairs. I show you the image, and ask you to guess the prompt. The I give you a score between 0 and 1. The scoring happens with a lighter version* of the [CLIP](https://huggingface.co/docs/transformers/model_doc/clip "CLIP") model used in the training of Stable Diffusion (cosine similarity for the math nerds out there).

The UI is made with Streamlit and hosted on [Steamlit Community Cloud](https://streamlit.io/cloud "Steamlit Community Cloud"). How extraordinarily cool of them to provide this for free!

> I hope you have _atleast_ as much fun playing around [diffAKI](https://diffaki.knhash.in "diffAKI") as I did building it.

***

\[*\] The actual model is trained on `clip-ViT-L-14` and is around 1.5GB. I couldn't get it loaded on Streamlit Cloud so I chose the lighter `clip-ViT-B-16` for running the comparisons. So in case the scores are off by a little, now you know why :)