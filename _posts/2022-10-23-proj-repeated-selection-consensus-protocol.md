---
layout: post
title: "[PROJ] Repeated Selection Consensus Protocol"
subtitle: Decision making among friends, with preferences
date: 2022-10-23 18:30:00 +0000
tags:
- general

---
The scenario is this:

> You are going on a vacation with your friends and there are going to be multiple occasions where decisions would need to be made.

These decisions could, of course, be held with a random number generator. This would give a fair and equal opportunity to all. But this does not take the person's _personal preference_ into account. I don't really care if I get shotgun on the 6 hour drive, but I really want a window seat. Someone else really prefers having the dorm bed farthest from the toilet. And so on.

The decision makers here are not changing, which is key. They are rational and will abide by the algorithm if it guarantees two things -

* is fair, over the course of the whole vacation
* accounts for the preference of the person in some form

A more generic example would be the passing of bills in a Parliament.

In this text I want to explore a new consensus protocol and I invite you to break it down. But gently please. This is, above all, a fun thought experiment.

_Or maybe this is not something new and I have woefully bad research skills_

***

Let us formally define the problem statement.

> Say there are _N_ (>1) agents who are to take _M_ (>1) decisions over a period of time _P_. For simplicity, say _M_ < _inf_, i.e., the number of decisions to be taken is known at the start of the period. The decisions taken should be
>
> 1. fair over the entire course _P_,
> 2. incorporate a measure of the agent's preference for some decisions over others.

What follows is the procedure that _I think_ is pretty neat. For lack of a creative name, I am calling this the **Repeated Selection Consensus Protocol**.

Every agent starts off with an equal number of tokens, _K_. There is three phases to every decision _m_ of _M_.

1. _Voting_: Every agent, _ni_, is asked to cast a number of tokens proportional to their preference. This vote count, _ki_, should be strictly a whole number. There is a uniform cost associated with the action of casting a vote, _c_ (1>c>0). These votes are secret. At the end of voting phase, every agent _ni_ has cast a set number of tokens, _ki + c._
2. _Redistribution_: At the end of a round if a single winner is identified as the _ni_ with the maximum _ki_, the decision has been reached. The winner gets the real world "prize" of the decision at the cost of spending their tokens (_kw+c_), where _w_ is the index of the winner. This cost is distributed among the non-winners, alongwith the cost of the individual actions - the total tokens to be distributed thus becoming _kw+ (N*c)_. The distribution is inversely proportional to the tokens spent by the user (_ki_).
3. _Re-voting_: In case there is a tie, the tokens spent by the agents in the current round go into a holding pot and a new round of voting takes place. The new tokens voted has to strictly be different from the previous vote (either more or less). This shold decrease the probability of future ties occuring. The re-voting phase repeats until the sum of tokens of an agent in the holding pot at any time is able to determine a unique winner. Upon such an event we move to redistrution phase and call the end of this decision.

The agent with the highest preference for a particular decision gets to win the result but at a cost. The agents with lower stakes in the decision are compensated with the tokens of the winner so they may use them in a future, more personally affable decision.

All the voting takes place in secret. Hence after the first vote, none of the agents have an equal number of tokens and it is not possible to figure out how much an agent has without a discussion among all agents.

***

_I am of the opinion that this is fair_. A random selection is unfair to the person who desperately wants a result and is willing to forgo their future decision making powers for it. This also puts the onus of bidding smartly on the agent, knowing that there is a cost to winning a decision, balancing the current want with a future need.

Consider the case where a minority representative wants to pass a bill that is extremely important to them but is unable to because of lack of a majority, one that is dependent on representatives who may not necessarily be motivated to pass it. This protocol should move away from the effects of majority rule.

What parts of the picture I am missing? Are there related material I can read up on that touches on this subject? 

Send in your thoughts at [mail@knhash.in](mailto:mail@knhash.in "mail@knhash.in").