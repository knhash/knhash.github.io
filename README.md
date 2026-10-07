# knhash.in file host

Static files, media, the resume (LaTeX) and old-URL redirects for the Bearblog at https://knhash.in.
The blog itself lives on Bearblog; this repo only serves what Bearblog can't.

## Layout
- `resume/ShashankResume.tex`: resume source (`\VARIANT` = master | recsys | platform | hpc). `ShashankResume.md` is the content reservoir.
- `files/` (PDFs), `media/` and `logos/` (images): public assets. Names are public URLs, so don't rename them.
- `redirects.csv`: every legacy path -> its latest URL on knhash.in. Add a line to add a redirect.
- `static/`: `_headers` / `_redirects` for the two Cloudflare sites.
- `scripts/`: `gen-redirects.py`, `check-urls.sh`.
- `theme/knhash.css`: the Bearblog theme. Source of truth for Dashboard → Themes → Custom CSS (Bearblog keeps no history, and "Apply" on a built-in theme overwrites it). Edit here, paste there, Publish.

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
