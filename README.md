# HotPlot shortcut

A tiny installable web app (PWA) that puts a **HotPlot** icon on Android and iOS home screens.
Tapping the icon opens https://hotplot.ai/.

hotplot.ai blocks being embedded in other sites (Cloudflare + `X-Frame-Options: SAMEORIGIN`),
so this redirects instead of mirroring. Once on hotplot.ai, phones show a thin browser bar at the top.

## Files

| File | Purpose |
|---|---|
| `index.html` | Landing page with install instructions; redirects to hotplot.ai when launched from the home screen |
| `manifest.json` | App name, icons, standalone display (Android/Chrome) |
| `sw.js` | Minimal service worker so Chrome offers "Install app" |
| `icons/` | Placeholder icons (regenerate with `tools/make-icons.ps1`, or replace with your own PNGs of the same size) |
| `render.yaml` | Render Blueprint for a free static site |

No database is needed, so Turso isn't used.

## Deploy on Render

1. Push this folder to a GitHub repo.
2. In Render: **New → Blueprint**, pick the repo (it reads `render.yaml`).
   Or **New → Static Site**, leave the build command empty, and set the publish directory to `.`
3. Open the `*.onrender.com` URL on your phone and add it to the home screen:
   - **iOS (Safari):** Share → Add to Home Screen
   - **Android (Chrome):** tap **Install app**, or ⋮ → Add to Home screen

## Customize

- Name: `name` / `short_name` in `manifest.json`, plus `<title>` and `apple-mobile-web-app-title` in `index.html`.
- Target URL: `TARGET_URL` in `index.html`.
- Icons: replace the PNGs in `icons/` (192, 512, maskable 512, and 180 for Apple).
  After changing icons, bump `CACHE` in `sw.js`, then remove and re-add the shortcut on the phone.
