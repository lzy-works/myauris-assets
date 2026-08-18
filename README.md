# myauris-assets

Brand assets and design tokens for the **MyAuris** (Nha Khoa My Auris) demo.

The client has no raw asset files — confirmed with Sơn on 2026-08-18 — so
everything here is pulled from the live site at <https://myauris.vn/> and the
tokens are read out of that site's compiled CSS.

**This repo is private and stays private.** The photos and the logo are the
clinic's property; we mirror them so the app has a stable, versioned source, not
to republish them. That also rules out jsDelivr/raw-CDN serving, which requires
a public repo — assets are consumed at *build* time and served by our own host.

## Layout

```
brand/logo/     logo SVG, favicons, apple-touch-icon
brand/icons/    hotline / clock / map / social glyphs
brand/photos/   service + banner photography (16 service shots, 5 banners)
brand/fonts/    Montserrat, Mulish, Dancing Script (woff2, OFL)
tokens/         tokens.css (CSS custom properties) and tokens.json
manifest.json   every file → its source URL on myauris.vn
scripts/        fetch-assets.sh — re-pull, or --check for drift
```

## Consuming this from the app

Don't fetch at runtime. Pull at build time so the release artifact is
self-contained and the demo has no third-party dependency:

```bash
# in myauris-ui/
git clone --depth 1 git@github.com:lzy-works/myauris-assets.git .brand-src
cp -r .brand-src/brand   static/brand
cp    .brand-src/tokens/tokens.css static/brand/tokens.css
```

Then import `tokens.css` once at the app root and reference the custom
properties. Never paste raw hex into a component — if the clinic re-brands, one
file changes.

## Refreshing

```bash
scripts/fetch-assets.sh          # re-pull everything
scripts/fetch-assets.sh --check  # detect drift without touching the tree
```

If `--check` reports drift, the clinic changed their site: re-run the plain
fetch, eyeball the diff, and re-derive tokens if the CSS colours moved.

## Provenance / licence

- Photography, logo, icons: © Nha Khoa My Auris. Mirrored for this engagement
  only. Do not redistribute, do not make this repo public.
- Fonts (Montserrat, Mulish, Dancing Script): SIL Open Font License 1.1,
  redistributable. They were already self-hosted on myauris.vn.
