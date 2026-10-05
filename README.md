# knhash.in file host

Static files, media, the resume (LaTeX) and old-URL redirects for the Bearblog at https://knhash.in.
The blog itself lives on Bearblog; this repo only serves what Bearblog can't.

## Layout
- `resume/ShashankResume.tex`: resume source (`\VARIANT` = master | recsys | platform | hpc). `ShashankResume.md` is the content reservoir.
- `files/`, `media/`, `logos/`: static assets. Paths are public URLs, so never rename or delete them.
- `redirects.csv`: every legacy path -> latest URL on knhash.in. Add a line to add a redirect.
- `static/`: extra files copied verbatim into the site (`_headers`, `_redirects` for Cloudflare).
- `scripts/`: `gen-redirects.py` (stubs from the CSV), `check-urls.sh` (link check).

## Build locally
Needs TeX Live (`brew install --cask mactex-no-gui`) or the Docker image `texlive/texlive`.
```bash
make site     # -> build/site (4 resume PDFs, static files, redirect stubs)
make clean
```

## Deploy
Push to `master`: GitHub Actions builds `build/site` and deploys it to
- GitHub Pages (https://knhash.github.io, legacy URLs) and
- Cloudflare Pages project `knhash-files` (https://files.knhash.in) when `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` secrets are set.

Built PDFs are never committed. PRs only build and attach the site as an artifact.

## Stable URLs
| URL | What |
|---|---|
| `/resume.pdf` | latest master resume |
| `/resume-{recsys,platform,hpc}.pdf` | tailored variants |
| `/files/ShashankResume*.pdf` | legacy paths, same PDFs |

Check links: `scripts/check-urls.sh [BASE_URL...]`.
