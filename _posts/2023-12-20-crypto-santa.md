---
published: true
layout: post
date: '2023-12-20 17:00:00 +0530'
tags:
  - general
  - project
title: >-
  Crypto Santa
subtitle: 'or, How To Overcomplicate A Simple Exercise While Pissing Off Ritesh'
---


> **Ritesh**: Will DM who you are santa for later at night. Unless you want to write code for this.  
> **Shashank**: I am already thinking. I will do.  
> **Vibhav**: ChatGPT 🤷🏻‍♂️  
> **Shashank**: Some form of public key encryption. Can do this as a service without saving any personal data, but revealing your Santa for you only …  
> **Shashank**: I hate how ChatGPT is the new “just google it”  

In Secret Santa the knowledge of who is whose Santa, the overall state of play, never exists. You write your names on chits, shuffle and draw a chit. It never even is *created*. Which is fascinating, I want to replicate that digitally, or get as close to it as possible.

The constraints for this exercise:

- No central authority - No one person should be able to find out who everyone’s Secret Santa is at any given point in the process
- Serverless implementation - do it without saving intermediate stages in a server, zero long term memory;
- Personal persistence - the Santa should be able to refer back and confirm their “chit”, in case they forget their assignment

> **Ritesh**: Yaar just wrap it up today only. Like why are we over complicating shit.  
> **Ritesh**: Don't want to copy everyone's keys and get a santa? Idk man.  
> **Shashank**: Do it. For the fun of it.  

Asymmetric key encryption is apt for it. Anybody can encode messages (using the public keys) that only a single person can decode (using their private key). Ask everyone to send their names and  public keys. Shuffle your names and encrypt it behind the individual public keys, generate a list of cypher texts. Everyone uses their private keys to decrypt this list, only a single item linked to their private key will be unlocked revealing who they are the Santa for.

Easy.

> **Ritesh**: Send the instructions  
> **Ritesh**: This is still the easiest(someone assigning the santas). Lets just get done with.  

1. Everyone go to Tab one. Put in your name. You’ll get a private key and public key. Copy and save both.
2. Share your public key AS IS here.
3. One of us (me) takes all the public keys and puts it in Tab two. I get a list of encrypted messages.
4. I put the encrypted messages in this group here.
5. Everyone put the whole set of encrypted messages and your PRIVATE key in tab three.

You have your secret Santa. 🎅

For the lack of enough Javascript knowledge to do this in a couple hours I used Streamlit + Python which is *technically* using a server for compute but this can be implemented in pure client side code. For a tiny fraction of time there does exist the mapping of Santas in code, while shuffling, which one could log and figure out the assignments. In spirit this is serverless.

In spirit it is serverless though.

Anybody can also pass the list of cypher text with their private key to reliably retrieve their assignment.

> **Ritesh**: Too complicated and involves coordination.  
> **Shashank**: Bruh. Try. Everyone has to do step 1,2,5. That’s all  
> **Ritesh**: Dude your offering shouldn't have three steps  
> **Shashank**: Ok, agreed it is not the best UX. This was a theoretical exercise mostly to see if you can replicate the Secret Santa working of the offline world with all its advantages.  
> **Ritesh**: You can't with this. There are already apps for that. Way more easier to use. Put in emails, hit buttons, and folks get emails on who they are santa for

In the end I have a toy that took a couple hours to build - not including the one hour to debug an encryption bug (evidently 512 bytes is too small a size to meaningfully encrypt anything) - and a debate which I lost, in spirit.

On Vibhav’s insistence I asked ChatGPT how it would solve it and it spat out the code to do pretty much the same thing in 10 odd minutes of prompting.

I’m still proud of it though, I had fun. This goes on my wall of toys.

[https://cryptosanta.knhash.in](https://cryptosanta.knhash.in)

> **Shashank**: It is a beautiful, theoretical, mathematical exercise, why can you not see it for that 😭  
> **Ritesh**: Beauty is in the eye of beholder

🥲

