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

| Tier | Assets | Size | What it is |
|---|---:|---:|---|
| `chrome` | 29 | 2.6 MB | On 3,000+ pages. Logo, favicons, header banner, hotline/map/clock glyphs, language flags. |
| `marketing` | 1,048 | 825 MB | Service and category pages: clinical photography, doctor portraits, before/after galleries, 19 review videos. |
| `editorial` | 10,379 | ~1.6 GB | Appears on exactly one blog post. The SEO long tail. |

**11,456 unique assets, ~2.4 GB total.** 9,873 of them appear on exactly one
page — the brand system is really the 29 chrome assets plus a few hundred
marketing ones; the rest is article furniture.

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

Three assets are referenced by live pages but return 404:

- `wp-content/uploads/2016/08/dummy-1.jpg`
- `wp-content/uploads/2016/08/dummy-2.jpg`
- `wp-content/uploads/2022/08/nieng-rang-invisalign-o-dau-tot-04-600x600-1.jpg`

The first two are 2016 theme placeholders still wired into live templates. Not
our problem to fix, but they are the kind of thing to mention once.

## Two favicon sets

The site carries a root set (`/favicon.svg`, `/favicon.ico`, `/favicon-96x96.png`,
`/apple-touch-icon.png`) and a separate 2025 `apple-touch-icon.png` under
uploads, declared in the same `<head>`. They do not match each other. Pick the
root set as canonical.
