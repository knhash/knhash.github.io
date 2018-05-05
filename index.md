---
layout: 
title: "Shashank"
---


<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>{{ site.name }} | {{ page.title }}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/x-icon" href="{% asset favicon.ico @path %}">
  <link rel="apple-touch-icon" href="{% asset apple-touch-icon.png @path %}">

  {% if site.local_fonts %}
    {% asset fonts.css %}
  {% endif %}

  {% if site.blog_theme == "light" %}
    {% asset home-light.css %}
  {% else %}
    {% asset home-dark.css %}
  {% endif %}
</head>
<body>
  <main class="home-wrapper">
    <div class="home-content">
      <h1><a href="{{ 'about' | relative_url }}" title="About">{{ site.name }}</a></h1>
      <p><a href="https://in.linkedin.com/in/{{ site.social.linkedin }}" rel="noreferrer noopener" target="_blank" title="LinkedIn">
          Professional</a> | Riddler | <a href="https://github.com/{{ site.social.github }}" rel="noreferrer noopener" target="_blank" title="GitHub">
          Coder</a> | Doodler | <a href="{{ '/blog' | relative_url }}" title="Blog">Writer</a> | Designer | <a href="https://{{ site.resume }}" rel="noreferrer noopener" target="_blank" title="Resume">
          Developer</a></p>
    </div>
  </main>


  {% unless site.local_fonts %}
    {% asset webfonts.js %}
  {% endunless %}
</body>
</html>

