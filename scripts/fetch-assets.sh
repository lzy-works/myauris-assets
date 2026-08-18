#!/usr/bin/env bash
# Re-pull every asset in manifest.json from the live myauris.vn site.
# The client has no raw asset files, so the site is the source of truth.
# Usage: scripts/fetch-assets.sh [--check]
#   --check  fetch to a temp dir and diff against the committed copies
set -euo pipefail

cd "$(dirname "$0")/.."
UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126 Safari/537.36'
DEST="."
if [[ "${1:-}" == "--check" ]]; then
  DEST="$(mktemp -d)"
  echo "check mode -> $DEST"
fi

fail=0
while IFS=$'\t' read -r path url; do
  out="$DEST/$path"
  mkdir -p "$(dirname "$out")"
  if curl -fsSL -A "$UA" "$url" -o "$out"; then
    printf '  ok   %-42s %s\n' "$path" "$(wc -c <"$out" | tr -d ' ') bytes"
  else
    printf '  FAIL %-42s %s\n' "$path" "$url"
    fail=1
  fi
done < <(python3 -c '
import json,sys
for a in json.load(open("manifest.json"))["assets"]:
    print(a["path"], a["url"], sep="\t")
')

if [[ "${1:-}" == "--check" ]]; then
  diff -rq brand "$DEST/brand" && echo "no drift" || { echo "DRIFT: site assets changed"; fail=1; }
fi

exit "$fail"
