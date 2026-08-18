#!/usr/bin/env bash
# Materialise media from media/media-map.json by tier.
#
# The full site carries ~2.4 GB of media across 11,456 assets, so none of it is
# committed. The map is the deliverable; this script pulls whichever slice you
# actually need into media/<tier>/ (gitignored).
#
# Usage:
#   scripts/fetch-media.sh chrome              # 29 files, ~2.6 MB — site furniture
#   scripts/fetch-media.sh marketing           # 1048 files, ~825 MB (669 MB is video)
#   scripts/fetch-media.sh marketing --no-video  # 1029 files, ~156 MB
#   scripts/fetch-media.sh editorial           # 10379 files, ~1.6 GB — the blog long tail
#   scripts/fetch-media.sh all --no-video
#   scripts/fetch-media.sh marketing --list    # print URLs, download nothing
set -euo pipefail

cd "$(dirname "$0")/.."
TIER="${1:-}"
[[ -z "$TIER" ]] && { sed -n '2,17p' "$0" | sed 's/^# \{0,1\}//'; exit 1; }
shift || true
NOVIDEO=0; LIST=0
for arg in "$@"; do
  case "$arg" in
    --no-video) NOVIDEO=1 ;;
    --list)     LIST=1 ;;
    *) echo "unknown option: $arg" >&2; exit 1 ;;
  esac
done

UA='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126 Safari/537.36'
DEST="media/$TIER"

# NB: no mapfile — macOS ships bash 3.2 and this script has to run there too.
URLS=()
while IFS= read -r line; do URLS+=("$line"); done < <(python3 - "$TIER" "$NOVIDEO" <<'PY'
import json, sys
tier, novideo = sys.argv[1], sys.argv[2] == "1"
d = json.load(open("media/media-map.json"))
for path, meta in d["assets"].items():
    if tier != "all" and meta["tier"] != tier:
        continue
    if novideo and path.lower().endswith((".mp4", ".webm", ".mov")):
        continue
    print(path)
PY
)

echo "${#URLS[@]} assets in tier '$TIER'"
if [[ "$LIST" == 1 ]]; then
  printf 'https://myauris.vn/%s\n' "${URLS[@]}"
  exit 0
fi

mkdir -p "$DEST"
n=0; fail=0
for path in "${URLS[@]}"; do
  out="$DEST/$path"
  mkdir -p "$(dirname "$out")"
  if [[ -s "$out" ]]; then continue; fi
  if curl -fsSL -A "$UA" "https://myauris.vn/$path" -o "$out"; then
    n=$((n+1))
    (( n % 50 == 0 )) && echo "  $n fetched"
  else
    echo "  FAIL $path" >&2
    rm -f "$out"
    fail=$((fail+1))
  fi
done
echo "fetched $n, failed $fail, into $DEST"
exit $(( fail > 0 ))
