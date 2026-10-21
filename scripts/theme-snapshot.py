#!/usr/bin/env python3
"""Download every knhash.in page into <outdir> for previewing theme/knhash.css.

Usage: theme-snapshot.py <outdir>

Pages: the sitemap (minus redirect stubs), /blog/ and the 404 page. Each page's Bearblog
stylesheet is replaced with a link to theme/knhash.css. Links between downloaded pages point
to the local files; other knhash.in links and forms point to "#". Bearblog's analytics,
upvote and timezone scripts are removed.
"""
import os
import re
import sys
import urllib.error
import urllib.parse
import urllib.request

SITE = "https://knhash.in"
UA = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130 Safari/537.36"
NOT_FOUND = "/this-page-does-not-exist/"
EXTRA = ["/blog/", NOT_FOUND]  # not in the sitemap

# Bearblog scripts that send analytics or set cookies.
DROP_SCRIPT = re.compile(r"src = `/hit/|/upvote-info/|document\.cookie = `timezone")
# Stub fetch() to ntfy.knhash.in; the preview sends no notes.
FETCH_STUB = """<script>
(() => { const f = window.fetch; window.fetch = (u, o) => String(u).includes('ntfy.knhash.in') ? Promise.resolve(new Response(null, { status: 200 })) : f(u, o); })();
</script>"""
# Live reload over HTTP: poll theme/knhash.css every 500ms; on change, load the new sheet, then remove the old one.
LIVE_RELOAD = """<script>
(() => {
  if (!location.protocol.startsWith("http")) return;
  let link = document.querySelector("link[data-theme]"), last;
  setInterval(async () => {
    const css = await fetch(link.href, { cache: "no-store" }).then(r => r.text()).catch(() => last);
    if (last !== undefined && css !== last) {
      const old = link;
      link = old.cloneNode();
      link.href = old.href.split("?")[0] + "?" + Date.now();
      link.onload = () => old.remove();
      old.after(link);
    }
    last = css;
  }, 500);
})();
</script>"""
URL_ATTR = re.compile(r"""\b(href|src|action|data)=(["'])(.*?)\2""")


def fetch(path, tries=3):
    """(final path after redirects, html)."""
    req = urllib.request.Request(SITE + path, headers={"User-Agent": UA})
    try:
        with urllib.request.urlopen(req, timeout=30) as r:
            return urllib.parse.urlsplit(r.url).path, r.read().decode(errors="replace")
    except urllib.error.HTTPError as e:  # keep the 404 page itself
        return path, e.read().decode(errors="replace")
    except (urllib.error.URLError, TimeoutError):
        if tries > 1:
            return fetch(path, tries - 1)
        sys.exit(f"{path}: timed out")


def page_key(path):
    return "/" + path.strip("/") + "/" if path.strip("/") else "/"


def file_name(key):
    return "index.html" if key == "/" else "404.html" if key == NOT_FOUND else key.strip("/").replace("/", "-") + ".html"


def site_path(url):
    """The knhash.in path a URL points at, or None for other sites."""
    if url.startswith("/") and not url.startswith("//"):
        url = SITE + url
    if url == SITE or url.startswith(SITE + "/"):
        return url[len(SITE):] or "/"
    return None


def main():
    out = sys.argv[1] if len(sys.argv) > 1 else "build/theme"
    css_href = os.path.relpath("theme/knhash.css", out)

    _, sitemap = fetch("/sitemap.xml")
    paths = [urllib.parse.urlsplit(u).path for u in re.findall(r"<loc>([^<]+)</loc>", sitemap)] + EXTRA
    fetched = {p: fetch(p) for p in paths}  # sequential; parallel requests get rate-limited
    pages = {page_key(p): html for p, (_, html) in fetched.items()
             if 'http-equiv="refresh"' not in html}  # skip redirect stubs
    for key, html in pages.items():
        if 'data-name="default"' not in html:
            sys.exit(f"{key}: no Bearblog stylesheet found (blocked or page changed?)")

    # Resolve links to old slugs and aliases to the pages they redirect to.
    unknown = {p.split("#")[0] for html in pages.values() for _, _, u in URL_ATTR.findall(html)
               if (p := site_path(u)) and "?" not in p and page_key(p.split("#")[0]) not in pages}
    aliases = {p: page_key(fetch(p)[0]) for p in unknown}

    def localise(attr, url):
        path = site_path(url)
        if path is None:
            return url
        path, _, frag = path.partition("#")
        key = page_key(aliases.get(path, path)) if "?" not in path else None
        if key in pages:
            return file_name(key) + (f"#{frag}" if frag else "")
        return SITE + path if attr in ("src", "data") else "#"  # assets from the live site; links and forms to "#"

    def swap_theme(m):
        # Keep the .upvote-button rules Bearblog appends after the custom CSS.
        css = m.group(1)
        # Match Bearblog's ".upvote-button {", not the theme's "button.upvote-button {".
        bear = re.search(r"(?<![\w-])\.upvote-button \{", css)
        appended = css[bear.start():] if bear else ""
        return f'<link rel="stylesheet" href="{css_href}" data-theme>\n<style>{appended}</style>\n{LIVE_RELOAD}'

    # Delete old pages only after every fetch has succeeded.
    os.makedirs(out, exist_ok=True)
    for old in os.listdir(out):
        if old.endswith(".html"):
            os.remove(os.path.join(out, old))
    for key, html in pages.items():
        html = re.sub(r'<style data-name="default">(.*?)</style>', swap_theme, html, count=1, flags=re.S)
        html = re.sub(r"<script\b[^>]*>.*?</script>",
                      lambda m: "" if DROP_SCRIPT.search(m.group(0)) else m.group(0), html, flags=re.S)
        html = html.replace("<head>", "<head>\n" + FETCH_STUB, 1)
        html = URL_ATTR.sub(lambda m: f"{m.group(1)}={m.group(2)}{localise(m.group(1), m.group(3))}{m.group(2)}", html)
        with open(os.path.join(out, file_name(key)), "w") as f:
            f.write(html)
    print(f"  {len(pages)} pages -> {out}/ ({len(fetched) - len(pages)} redirect stubs skipped)")


if __name__ == "__main__":
    main()
