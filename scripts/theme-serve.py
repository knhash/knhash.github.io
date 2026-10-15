#!/usr/bin/env python3
"""Serve the repo root for the theme preview, with caching off.

Usage: theme-serve.py [port]
"""
import http.server
import os
import re
import sys

PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8765
os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
# Footer directive span, through the optional "Powered by" span and </footer>.
FOOTER = re.compile(r'(<span id="footer-directive">).*?(</span>\s*(?:<span>.*?</span>\s*)?</footer>)', re.S)


class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        path = self.path.split("?")[0]
        # Point media.knhash.in URLs in the theme at the local media/ folder.
        if path == "/theme/knhash.css":
            body = open("theme/knhash.css", "rb").read().replace(b"https://media.knhash.in/", b"/media/")
            return self.send_body(body, "text/css; charset=utf-8")
        # Replace the footer directive in snapshot pages with theme/footer.html.
        page = self.translate_path(self.path)  # decoded, confined to the repo root
        if path.startswith("/build/theme/") and path.endswith(".html") and os.path.isfile(page) and os.path.isfile("theme/footer.html"):
            with open(page, encoding="utf-8") as f:
                html = f.read()
            with open("theme/footer.html", encoding="utf-8") as f:
                footer = f.read()
            html, swapped = FOOTER.subn(lambda m: m.group(1) + footer + m.group(2), html, count=1)
            if not swapped:
                print(f"{path}: no footer directive found; serving the live footer", file=sys.stderr)
            return self.send_body(html.encode(), "text/html; charset=utf-8")
        super().do_GET()

    def send_body(self, body, content_type):
        self.send_response(200)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def end_headers(self):
        self.send_header("Cache-Control", "no-store")
        super().end_headers()

    def log_message(self, *args):  # no request logs; live reload polls every 500ms
        pass


print(f"Preview: http://localhost:{PORT}/build/theme/  (edit theme/knhash.css; Ctrl-C to stop)")
try:
    http.server.ThreadingHTTPServer(("127.0.0.1", PORT), Handler).serve_forever()
except KeyboardInterrupt:
    pass
