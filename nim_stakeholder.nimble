version       = "0.1.0"
author        = "stakeholder-circus"
description   = "Deterministic Nim rewrite tranche for stakeholder-circus"
license       = "MIT"
srcDir        = "src"
bin           = @["stakeholder"]
requires "nim >= 1.6.0"

task test, "Run repository tests":
  exec "nim c -r --path:src tests/test_stakeholder.nim"

task checks, "Run semantic checks":
  exec "nim check src/stakeholder.nim"
  exec "nim check --path:src tests/test_stakeholder.nim"
