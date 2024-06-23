---
layout: default
title: Hello Mr Shank
description: "Dashboard of services at various places and stuff"
permalink: /workshop
---

## Aside Articles

|[Homemade Pi]({{ site.other_links.HomemadePi }} "Homemade Pi") | A manifesto against ads, and a possible side hustle|


<style>
    .workshop-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        grid-gap: 20px;
    }

    .workshop-item {
        text-align: center;
    }

    .workshop-item img {
        border-radius: 10px; /* Rounded corners */
        margin-bottom: 10px;
        width: 100%;
        height: auto;
        max-width: 300px;
        max-height: 169px;
    }
</style>

## Showcase

<div class="workshop-grid">
    <div class="workshop-item">
        <a href="{{ site.other_links.DarkMoney }}" title="Dark Money">
            <img src="/media/web-snapshots/DarkMoney.png" alt="Dark Money Screenshot">
        </a>
        <div>The last personal finance dashboard you need</div>
    </div>

    <div class="workshop-item">
        <a href="{{ site.other_links.CAT }}" title="Cat Activity Tracker">
            <img src="/media/web-snapshots/CAT.png" alt="CAT Screenshot">
        </a>
        <div>A Cat Activity Tracker</div>
    </div>

    <div class="workshop-item">
        <a href="{{ site.other_links.GhostGame }}" title="Ghost Game">
            <img src="/media/web-snapshots/GhostGame.png" alt="Ghost Game Screenshot">
        </a>
        <div>A multiplayer word game, do _not_ complete the word.</div>
    </div>

    <div class="workshop-item">
        <a href="{{ site.other_links.DiffAKI }}" title="DiffAKI">
            <img src="/media/web-snapshots/DiffAKI.png" alt="DiffAKI Screenshot">
        </a>
        <div>A pictionary game, with Stable Diffusion</div>
    </div>

    <div class="workshop-item">
        <a href="{{ site.other_links.Wazir }}" title="Wazir">
            <img src="/media/web-snapshots/Wazir.png" alt="Wazir Screenshot">
        </a>
        <div>The general purpose image and text combinator</div>
    </div>

    <div class="workshop-item">
        <a href="{{ site.other_links.theThing }}" title="The Thing">
            <img src="/media/web-snapshots/TheThing.png" alt="The Thing Screenshot">
        </a>
        <div>Scan your face to check if you have "the thing"</div>
    </div>

    <div class="workshop-item">
        <a href="{{ site.other_links.ColorMood }}" title="Color Mood">
            <img src="/media/web-snapshots/ColorMood.png" alt="Color Mood Screenshot">
        </a>
        <div>Find your favourite color of your current mood</div>
    </div>

    <div class="workshop-item">
        <a href="{{ site.other_links.CryptoSanta }}" title="Crypto Santa">
            <img src="/media/web-snapshots/CryptoSanta.png" alt="Crypto Santa Screenshot">
        </a>
        <div>Secret Santa with asymmeteric key encryption</div>
    </div>

    <div class="workshop-item">
        <a href="{{ site.other_links.TransactionsConverter }}" title="Transactions Converter">
            <img src="/media/web-snapshots/TransactionsConverter.png" alt="Transactions Converter Screenshot">
        </a>
        <div>Extract transaction from PDF files into CSV format</div>
    </div>
</div>