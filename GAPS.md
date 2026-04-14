> [!NOTE]
> Missing or deferred behavior must fail fast and be tracked explicitly. No placeholder behavior should mask absent parity work.

# Nim Gaps

## Current explicit gaps
- `nim-stakeholder.post-modern-core-pending`: `ai_governance`, `security_blockchain`, `health_protocol`, and `overlay_quantum` remain grouped fallback rather than dedicated lanes.
- `nim-stakeholder.experimental-provider-pending`: live-provider adapters remain a current open gap in the full live-provider expansion lane; `--experimental-provider` fails fast explicitly.
- `nim-stakeholder.browser-session-pending`: browser/session capture and credentialed integration harnesses remain open gaps in the later live-provider expansion lane.
- `nim-stakeholder.codeql-pending`: GitHub CodeQL is not wired for this repo in the current tranche.
- `nim-stakeholder.publication-held`: local validation is complete, but the repo remains local-only until at least 10 validated full rewrites exist.

## Guardrail
- Do not present this repo as publication-ready or provider-capable beyond the explicit deterministic contract implemented here.
