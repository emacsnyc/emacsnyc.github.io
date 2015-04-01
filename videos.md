---
layout: default
title: (emacs-nyc videos)
---

### Videos

We record our talks and make them available here. You can watch them
through YouTube (which we appreciate for bandwidth reasons) or you can
download a copy for offline use. Enjoy!

<ul>
  {% for post in site.posts %}
    {% if post.tags contains "video" %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endif %}
  {% endfor %}
</ul>

---

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/MovingImage" property="dct:title" rel="dct:type">Video</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://emacsnyc.org" property="cc:attributionName" rel="cc:attributionURL">The New York Emacs Meetup</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
