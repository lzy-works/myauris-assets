# MyAuris brand study — myauris.vn

Captured 2026-08-18 by parsing the live site's HTML, inline `<style>` blocks
(208 of them, ~52 KB) and the Autoptimize-compiled stylesheets.

## Identity

| | |
|---|---|
| Name | Nha Khoa My Auris |
| Tagline | *Khách hàng là người nhà – luôn chu toàn* |
| Platform | WordPress (Flatsome theme + Elementor), Autoptimize, CF7 |
| Language | Vietnamese (an English toggle exists but is thin) |
| Address | 11 Bis Nguyễn Gia Thiều, P. Xuân Hòa, TP.HCM |
| Hotline | 0906 038 017 (24/7), hours 08:30–18:00 |
| Social | Facebook, Instagram, TikTok, Pinterest, YouTube, Zalo, Viber |
| Logo | `logo-myauris-9-2024.svg` — violet `#9084d0` mark with red accents (`#ee4036`/`#df1f26`) |

## Palette — it is **purple/magenta, not blue**

Worth stating plainly: a first glance (and most automated summaries) call this a
blue healthcare site. It isn't. The whole system is plum → violet with a magenta
CTA accent.

**Core (plum → violet)**
`#26143b` plum-900 · `#29133d` · `#412f61` · `#403060` violet-600 (every h1–h6)
· `#7468a9` violet-500 (menu overlay) · `#8e84cd` violet-400 (hover/chips) ·
`#867bc2` · `#f8f7ff` tint

**Accent (magenta — primary CTA / active state)**
`#e5007f` (nav hover, button hover, current menu item) · `#db007f` · `#e332ad` ·
`#e3328f` · `#e55088`

**Secondary purples, on the 2024/25 pages**
`#682f90` · `#822a85` · `#8b2a8d` · `#681671` · `#49184c` · `#7b56eb` indigo

**Neutrals** — body `#212121`, nav/secondary `#333`, surfaces `#fff` / `#f7f7f7`
/ `#f1f1f1` (header strip), border `#eaeaea`

There are effectively **two generations of tokens** on the site: an older
plum/violet set and a newer purple→magenta set introduced with the Sept-2024
pages. They coexist. For the app, treat plum/violet as structure and magenta as
the single accent — that is the reading that keeps both generations coherent.

**Gradients**, always at 45°:
- heading — `linear-gradient(45deg, #26143b, #403060 90%)`
- brand — `linear-gradient(45deg, #682f90, #e332ad 90%)`
- accent — `linear-gradient(45deg, #e5007f, #7b56eb)`

## Type

- **Montserrat** — headings, nav, buttons, `.heading-font`
- **Mulish** — body copy
- **Dancing Script** / *Ms Madi* / *Prata* — decorative pull-quote headings only
- Self-hosted woff2 under `/wp-content/fonts/` (OMGF plugin), so they are already
  detached from Google Fonts. All three are OFL — safe to vendor.
- **Only three faces/weights actually ship: Montserrat 700, Mulish 400, Dancing
  Script 400** — each split into `latin` / `latin-ext` / `vietnamese` subsets.
  Everything else on the site (Montserrat 400, Mulish 700) is *browser-synthesised*.
  If the app wants real intermediate weights, pull them from Google Fonts rather
  than faking them.
- **The vietnamese subset is load-bearing.** Drop it and every diacritic — the
  entire product vocabulary — silently falls back to a system face. `tokens.css`
  declares all three subsets with their `unicode-range`; keep them together.

## Component behaviour worth copying

| Element | Rule on the site |
|---|---|
| Headings | `#403060`, Montserrat 700 |
| Nav link | `#333` → hover `#e5007f`, some templates hover `#8e84cd` |
| Active nav item | white on `#e5007f` |
| Dropdown panel | `#26143b`, white links |
| Dropdown hover | `rgb(142 132 204 / 13%)` wash |
| Primary button | `#333` fill → hover `#e5007f` fill, white text |
| Outline button | `#eaeaea` → hover `#822a85` fill, white text |
| Tag / chip hover | fill and border both `#8e84cd` |
| Pagination | `#822a85` → hover white on fill |
| Section headings | gradient-clipped text (`.text-gradient`) |

## Contrast (WCAG 2.1, computed)

Passes AA for normal text: `#403060` on white **11.6**, `#26143b` on white
**16.9**, `#e5007f` on white **4.53**, white on `#e5007f` **4.53**, white on
`#7468a9` **4.89**, `#682f90` on white **8.76**, `#7b56eb` on white **4.8**.

Large text only (≥18.66px bold / 24px): `#8e84cd` on white **3.32**, `#e332ad`
on white **3.94**.

`#e5007f` at 4.53 clears AA but only just — do not put it on a tinted background
or shrink it below 16px in body copy. For small text use `#403060`; keep the
magenta for buttons, active states and ≥16px links.

## Asset inventory pulled

41 files: logo SVG + 4 favicon variants, 6 UI glyph SVGs, 5 social PNGs,
5 banners, 16 service photographs, 1 hero PNG, 5 woff2 fonts. Full source-URL
map in `manifest.json`.

Service photography maps 1:1 onto the clinic's service taxonomy — bọc răng sứ,
phủ sứ, dán sứ veneer, cầu răng sứ, implant, niềng mắc cài, niềng trong suốt,
cạo vôi, trám, điều trị tuỷ, nhổ răng, nhấn lợi. That is the vocabulary the demo
should use in Vietnamese, and it lines up with the assistant/department split
already in `rbac-policy.json`.

## What the site does *not* give us

- No `favicon`-independent monochrome/knockout logo — only the full-colour SVG.
  A dark-surface variant will have to be made (the mark's reds sit badly on
  `#26143b`).
- No product/app screenshots, no illustration set, no empty-state art.
- No brand book, no spacing scale, no defined shadow/radius language — the
  theme's spacing is Flatsome defaults, which are not worth copying into a
  Svelte app. Pick our own scale; only colour, type and imagery transfer.
