# Toolchain contract

## Native commands
- `nimpretty src/stakeholder.nim src/stakeholder_runtime.nim tests/test_stakeholder.nim`
- `nim check src/stakeholder.nim`
- `nim check --path:src tests/test_stakeholder.nim`
- `nimble build -y`
- `nimble test -y`

## Docker gate
- `docker build -t nim-stakeholder .`
- runtime smokes:
  - `--list-values --output-format json`
  - representative classic-six JSON
  - representative modern-core JSON
  - deterministic same-seed comparison
  - explicit `--experimental-provider` fail-fast

## Local versions used in this tranche
- Nim compiler: `2.2.8`
- Nimble: `0.20.1`

## Nix
- `flake.nix` and `flake.lock` are present.
- `nix` is installed through the official multi-user macOS path.
