# AGENTS.md

Kanarek is an Android reader/player and its supporting Cloudflare Worker.

## Repository

- `app/`: Kotlin/Compose Android app, news widgets, radio/IPTV player and player widget.
- `worker/`: optional TypeScript Worker for feed proxying, discovery/scraping and synchronized state.
- The Worker is optional. An empty backend configuration must keep on-device feed parsing functional.
- Generated/build output is not maintained source.

## Working method

- Check `main`, open pull requests and recent changes before overlapping work.
- Keep one maintained source of truth per concern.
- Never commit credentials, tokens or private deployment metadata. Non-secret Wrangler
  configuration such as account, binding and resource IDs may stay in
  `worker/wrangler.jsonc` when required for reproducible deployment.
- Treat `megalinter-reports/updated_sources` as suggestions and apply only intended fixes.
