# knhash.in file host

Static files, media, the resume (LaTeX), old-URL redirects and the theme for https://knhash.in (Bearblog).

## Layout
- `resume/ShashankResume.tex`: resume source (`\VARIANT` = master | recsys | platform | hpc). `ShashankResume.md` has the full content.
- `files/` (PDFs), `media/` and `logos/` (images): public assets. File names are URLs; don't rename.
- `redirects.csv`: every legacy path -> its latest URL on knhash.in. Add a line to add a redirect.
- `static/`: `_headers` / `_redirects` for the two Cloudflare sites.
- `scripts/`: `gen-redirects.py`, `check-urls.sh`, and `theme-serve.py` / `theme-snapshot.py` for the theme preview.
- `theme/knhash.css`: Bearblog custom CSS (Dashboard → Themes). Bearblog keeps no history; applying a built-in theme overwrites it.
- `theme/footer.html`: Bearblog footer directive (Settings → Header and footer directives).
- `theme/guestbook.html`: body of the Guestbook page.
- Theme preview: `make theme`, then http://localhost:8765/build/theme/. CSS changes apply on save, footer changes on reload. `make snapshot` re-downloads the pages (~1 min).

## Hosts
| Host | Serves |
|---|---|
| `files.knhash.in` | PDFs. `/resume.pdf` is always the latest resume; also `/resume-{recsys,platform,hpc}.pdf` |
| `media.knhash.in` | images |
| `knhash.github.io` | legacy `/files/...`, `/media/...` and old-URL redirects, same content |
| `knhash.in` | the Bearblog. Old `/files/*.pdf` paths are Bearblog redirect pages (alias) to files.knhash.in |

## Build locally
Needs TeX Live (`brew install --cask mactex-no-gui`) or the Docker image `texlive/texlive`.
```bash
make site     # -> build/files, build/media, build/legacy
make clean
```

## Deploy
Push to `master`. GitHub Actions builds everything and deploys to GitHub Pages and, when the `CLOUDFLARE_API_TOKEN` / `CLOUDFLARE_ACCOUNT_ID` secrets exist, to Cloudflare Pages projects `knhash-files` and `knhash-media`.
Built PDFs are never committed. PRs only build.

Link check: `scripts/check-urls.sh`.
