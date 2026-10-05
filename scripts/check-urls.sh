#!/usr/bin/env bash
# Link check for the live hosts. Usage: scripts/check-urls.sh
# - knhash.github.io: every legacy redirect stub resolves to a 200 target, files and media still served
# - files.knhash.in / media.knhash.in: resume PDFs and every file in the repo
cd "$(dirname "$0")/.."
UA='Mozilla/5.0'; fail=0
code() { curl -sL -m 30 -A "$UA" -o /dev/null -w '%{http_code}' "$1"; }
bad() { echo "FAIL $1 ($2)"; fail=1; }

echo "== legacy redirects (github.io)"
while IFS=, read -r path target _; do
  [ "$path" = path ] && continue
  meta=$(curl -sL -m 30 -A "$UA" "https://knhash.github.io$path" | grep -oiE 'url=[^"]+' | head -1 | cut -c5-)
  [ "$meta" = "$target" ] || bad "$path stub target '$meta' != '$target'" -
  c=$(code "$target"); [ "$c" = 200 ] || bad "$path -> $target" "$c"
done < redirects.csv

echo "== files"
for f in resume.pdf resume-recsys.pdf resume-platform.pdf resume-hpc.pdf $(cd files && ls *.pdf); do
  [[ $f == resume* ]] || { c=$(code "https://knhash.github.io/files/$f"); [ "$c" = 200 ] || bad "github.io/files/$f" "$c"; }
  c=$(code "https://files.knhash.in/$f"); [ "$c" = 200 ] || bad "files.knhash.in/$f" "$c"
done

echo "== media"
while read -r p; do
  c=$(code "https://media.knhash.in/${p#media/}"); [ "$c" = 200 ] || bad "media.knhash.in/${p#media/}" "$c"
  c=$(code "https://knhash.github.io/$p"); [ "$c" = 200 ] || bad "github.io/$p" "$c"
done < <(git ls-files media)

[ $fail -eq 0 ] && echo "all ok" || echo "FAILURES"
exit $fail
