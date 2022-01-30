---
layout: default-other-css
title: Homemade Pi
permalink: /homemade-pi
description: ""
---

#### for a cleaner, better internet

<br><br><br><br><br>

## Advertisements

We hate them. _It's coarse and rough and irritating and it gets everywhere._

What if you had a personal ad block server, with which you could...

- Protect your entire network fro malware ridden sites
- Block ads in apps and websites, on all your devices, no extra configuration
- Have faster network performance
- Monitor and control your network with a neat web interface
- (Or) Just set and forget it

<br><br><br><br><br>

## The Homemade Pi

A custom built a [Raspberry Pi](https://www.raspberrypi.org) server, preloaded with [Pi-Hole](https://pi-hole.net) and installed over your home internet network.

It is fully open source, hardware and software. Just a convenient packaging of it.  
Once installed it is yours 100%, *you own it*.  

<br><br><br><br><br>

## ₹6828/-

#### One time. Upfront.

<br><br><br><br><br>

Need ongoing technical assistance? **₹50/month**.  
No issues in a month? The money will be donated to the awesome folks at PiHole in your name!

<br><br><br><br><br>

### Drop your e-mail

For an interest check. No spam, no selling. **Promise**.

<br>

<iframe name="dummyframe" id="dummyframe" style="display: none;"></iframe>

<form name="listform" id="listform" method="post" action="https://listmonk.knhash.in/subscription/form" class="listmonk-form" target="dummyframe">
        <input id="email" type="email" name="email" placeholder="E-mail" onkeypress="clickPress(event)"/>
        <input id="7a5d2" type="hidden" name="l" checked value="7a5d2277-18d3-47da-a5e9-1301335fefbb" />
        <input id="submit-button" type="submit" value="I am interested" onclick="submission()"/>
</form>

<br><br><br><br><br>

<script>
    function submission() {
        document.getElementById('submit-button').value = 'Alright!';
        document.getElementById('submit-button').style.background = 'black';
        document.forms["listform"].submit();
        setTimeout(function() {
            document.getElementById('submit-button').value = 'I am interested';
            document.getElementById('submit-button').style.background = '#0d47a1';
            document.getElementById('email').value = '';
        }, 2000);
    }

    function clickPress(event) {
        if (event.keyCode == 13) {
            submission();
    }
}

</script>
