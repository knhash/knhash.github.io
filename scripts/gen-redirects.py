#!/usr/bin/env python3
"""Generate static redirect stubs from redirects.csv into an output dir.

Usage: gen-redirects.py OUTDIR
For path /foo writes OUTDIR/foo.html and OUTDIR/foo/index.html, so /foo and /foo/
both redirect on GitHub Pages and Cloudflare Pages.
"""
import csv, html, os, sys

TEMPLATE = """<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Redirecting...</title>
<link rel="canonical" href="{url}">
<meta http-equiv="refresh" content="0; url={url}">
<meta name="robots" content="noindex">
<script>location.replace({js});</script>
</head>
<body>Redirecting to <a href="{url}">{url}</a></body>
</html>
"""

def main(out):
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    with open(os.path.join(root, "redirects.csv"), newline="") as fh:
        rows = list(csv.DictReader(fh))
    for r in rows:
        path, target = r["path"].strip("/"), r["target"]
        page = TEMPLATE.format(url=html.escape(target, quote=True), js=repr(target))
        dest = [os.path.join(out, "index.html")] if not path else [
            os.path.join(out, path + ".html"), os.path.join(out, path, "index.html")]
        for d in dest:
            os.makedirs(os.path.dirname(d), exist_ok=True)
            with open(d, "w") as f:
                f.write(page)
    print(f"wrote {len(rows)} redirects to {out}")

if __name__ == "__main__":
    main(sys.argv[1])
