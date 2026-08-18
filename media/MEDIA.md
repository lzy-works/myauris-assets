# Media inventory — myauris.vn

Crawled 2026-08-18. Every URL in the Yoast sitemap index (3,097 pages) fetched
and parsed for `img` src, `srcset`, lazy-load attributes, `<picture><source>`,
`<video>` and poster frames, inline `background-image: url()`, and og/twitter
meta images. Zero page-fetch failures. WordPress resize variants (`-WxH`) are
folded back onto the original upload, so the counts below are real assets rather
than generated copies.

Note: the `sitemap:` lines in `robots.txt` are stale — they all serve the
homepage HTML with a 200. `sitemap_index.xml` is the live one.

## Tiers

All three tiers have been mirrored, so the sizes below are measured, not
estimated.

| Tier | Mapped | Fetched | Size | What it is |
|---|---:|---:|---:|---|
| `chrome` | 29 | 29 | 2.7 MB | On 3,000+ pages. Logo, favicons, header banner, hotline/map/clock glyphs, language flags. |
| `marketing` | 1,048 | 1,045 | 790 MB | Service and category pages: clinical photography, doctor portraits, before/after galleries, 19 review videos. |
| `editorial` | 10,379 | 10,307 | 852 MB | Appears on exactly one blog post. The SEO long tail. |

**11,456 unique assets mapped, 11,381 mirrored, 1.7 GB on disk.** 9,873 of them
appear on exactly one page — the brand system is really the 29 chrome assets
plus a few hundred marketing ones; the rest is article furniture.

The editorial tier came in at roughly half its projected size: those files
average ~84 KB against the marketing tier's ~150 KB, so an early extrapolation
from the marketing mean overstated the site total as ~2.4 GB. Measured, it is
1.7 GB.

## Video is most of the weight

19 files under `bkm-rs/` and `bkm-im/` account for **669 MB of the 825 MB**
marketing tier — customer testimonials served straight from wp-uploads with no
transcoding. Largest single file is 94.4 MB; the top four are 94, 74, 71 and
58 MB. Worth raising with the client independently of our work: it is their own
page-weight problem. It is also why these are not in git — 94.4 MB sits just
under GitHub's 100 MB hard per-file limit, and git history is permanent.

## Where the bytes are

The map is committed; the blobs are not. `scripts/fetch-media.sh` materialises
any tier on demand (`--no-video`, `--list`).

The bulk mirror lives on the demo VPS at **`/srv/myauris-media`**, fetched
directly there rather than round-tripping through a laptop. It is deliberately
**outside the served tree** — that host is on a public Funnel, and the clinic's
photography and testimonial videos must not become publicly fetchable from our
demo box. Copy curated files into the app's static directory individually.

## Broken references found on live pages

**75 assets are referenced by live pages and return HTTP 404** — 3 in the
marketing tier, 72 in editorial. Every failure in the mirror was a 404; nothing
failed for transport reasons.

Marketing tier:

- `wp-content/uploads/2016/08/dummy-1.jpg`
- `wp-content/uploads/2016/08/dummy-2.jpg`
- `wp-content/uploads/2022/08/nieng-rang-invisalign-o-dau-tot-04-600x600-1.jpg`

The first two are 2016 theme placeholders still wired into live templates.

Five of the 72 editorial failures have Vietnamese diacritics in the filename
(e.g. `img-niềng-rang-trong-suot.jpg`). That looked like a percent-encoding bug
in the fetcher, but both the raw and the percent-encoded URL return 404, so they
are genuinely missing rather than mis-requested.

None of this is ours to fix. It is worth mentioning to the client once — 75
broken images is an SEO and page-quality problem they probably do not know about.

## Two favicon sets

The site carries a root set (`/favicon.svg`, `/favicon.ico`, `/favicon-96x96.png`,
`/apple-touch-icon.png`) and a separate 2025 `apple-touch-icon.png` under
uploads, declared in the same `<head>`. They do not match each other. Pick the
root set as canonical.
