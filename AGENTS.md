# nim-stakeholder AGENTS

1. Preserve imported Rust history and explicit provenance docs; do not present this repo as greenfield work.
2. This repo is now an active wider-matrix local rewrite tranche and remains local-only until the 10-rewrite publication guardrail is lifted.
3. Preferred commands:
   - `nimpretty src/stakeholder.nim src/stakeholder_runtime.nim tests/test_stakeholder.nim`
   - `nim check src/stakeholder.nim`
   - `nim check --path:src tests/test_stakeholder.nim`
   - `nimble build -y`
   - `nimble test -y`
   - `docker build -t nim-stakeholder .`
4. Keep `origin` intended for `stakeholder-circus/nim-stakeholder` and `upstream` pointed at `https://github.com/giacomo-b/rust-stakeholder`.
5. Promotion work must preserve deterministic normalized JSON, explicit fail-fast gaps, and traceability rows back to Rust, Java, and stakeholder-core.
6. Do not hide missing behavior behind placeholders; record it in `GAPS.md` instead.
