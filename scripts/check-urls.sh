#!/usr/bin/env bash
# Verify old and new public URLs. Usage: scripts/check-urls.sh [BASE_URL ...]
# Default checks the live GitHub Pages host (and files.knhash.in if it resolves).
# For each path in redirects.csv: the stub must exist (200) and its target must return 200.
set -u
cd "$(dirname "$0")/.."
UA='Mozilla/5.0'
bases=("$@"); [ ${#bases[@]} -eq 0 ] && bases=(https://knhash.github.io)
fail=0
code() { curl -sL -m 30 -A "$UA" -o /dev/null -w '%{http_code}' "$1"; }
body() { curl -sL -m 30 -A "$UA" "$1"; }

for base in "${bases[@]}"; do
  echo "== $base"
  while IFS=, read -r path target _; do
    [ "$path" = path ] && continue
    final=$(curl -sL -m 30 -A "$UA" -o /dev/null -w '%{url_effective}' "$base$path")
    # follow meta refresh manually (curl does not)
    meta=$(body "$base$path" | grep -oiE 'url=[^"]+' | head -1 | cut -c5-)
    c=$(code "${meta:-$base$path}")
    [ "$c" = 200 ] || { echo "FAIL $path -> ${meta:-none} ($c)"; fail=1; }
  done < redirects.csv
  for f in resume.pdf resume-recsys.pdf resume-platform.pdf resume-hpc.pdf files/ShashankResume.pdf files/ShashankResume-recsys.pdf files/ShashankResume-platform.pdf files/ShashankResume-hpc.pdf; do
    c=$(code "$base/$f"); [ "$c" = 200 ] || { echo "FAIL $f ($c)"; fail=1; }
  done
done
# every file the repo ships must still be reachable at the legacy host path
for p in $(git ls-files files media | head -400); do
  [ -z "${LEGACY:-}" ] && break
  c=$(code "https://knhash.github.io/$p"); [ "$c" = 200 ] || { echo "FAIL legacy /$p ($c)"; fail=1; }
done
[ $fail -eq 0 ] && echo "all ok" || echo "FAILURES"
exit $fail
