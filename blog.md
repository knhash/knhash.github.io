---
layout: default
title: "Blog - Select ramblings of Knhash"
---
<!-- replace "site" with "paginator" to activate paginator -->
<ul class="article-list">
  {% for post in site.posts %}
    <li class="article-list-item {% if site.scrollappear_enabled %}scrollappear{% endif %}">
      <a href="{{ post.url | relative_url }}" title="{{ post.title }}">
        <h5>
          {{ post.title }}
          {% include svg-icon.html icon="arrow-right" %}
        </h5>
      </a>
      <p>
        {% if post.description %}
          {{ post.description }}  
        {% else %}
          {{ post.excerpt }}
        {% endif %}
      </p>
      <div class="article-list-footer">
        <span class="article-list-date">
          {{ post.date | date: "%B %-d, %Y" }}
        </span>
        <span class="article-list-divider">-</span>
        <span class="article-list-minutes">
          {% capture words %}
            {{ post.content | number_of_words }}
          {% endcapture %}
          {% unless words contains "-" %}
            {{ words | plus: 250 | divided_by: 250 | append: " minute read" }}
          {% endunless %}
        </span>
        <span class="article-list-divider">-</span>
        <div class="article-list-tags">
          {% for tag in post.tags %}
            <a href="{{ 'tag/' | relative_url }}{{ tag }}">{{ tag }}</a>
          {% endfor %}
        </div>
      </div>
    </li>
  {% endfor %}
  {% if site.total_pages > 1 %}
    <li class="article-pagination {% if site.settings.scrollappear_enabled %}scrollappear{% endif %}">
      {% if site.next_page %}
        <a href="{{ site.next_page_path }}" class="article-pagination-left">Older posts</a>
      {% endif %}
      {% if site.previous_page %}
        <a href="{{ site.previous_page_path }}" class="article-pagination-right">Newer posts <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
        <symbol id="icon-arrow-right" viewBox="0 0 16 16">
        <title>arrow-right</title>
        <path d="M15.429 7.973c0 0.080-0.036 0.161-0.089 0.214l-3.429 3.161c-0.089 0.080-0.205 0.098-0.313 0.054-0.098-0.045-0.17-0.143-0.17-0.259v-2h-11.143c-0.161 0-0.286-0.125-0.286-0.286v-1.714c0-0.161 0.125-0.286 0.286-0.286h11.143v-2c0-0.116 0.063-0.214 0.17-0.259s0.223-0.027 0.313 0.045l3.429 3.125c0.054 0.054 0.089 0.125 0.089 0.205v0z"></path>
        </symbol>
        </svg></a>
      {% endif %}
    </li>
  {% endif %}
</ul>
 
