import std/[json, sequtils, strutils, unittest]
import stakeholder_runtime

suite "nim-stakeholder":
  test "list-values json exposes full registry with renderer metadata":
    let result = runApp(@["--list-values", "--output-format", "json"])
    check result.exitCode == 0
    let payload = parseJson(result.stdout)
    check payload["count"].getInt == 15
    check payload["families"].len == 15
    let names = payload["families"].getElems.mapIt(it["family"].getStr)
    check "code_analyzer" in names
    check "supply_chain_security" in names
    check "overlay_quantum" in names
    for family in payload["families"].getElems:
      check family.hasKey("rendererKey")
      check family.hasKey("sourceTrace")

  test "classic-six family emits normalized json events":
    let result = runApp(@["--focus-family", "data_processing",
        "--output-format", "json", "--seed", "alpha"])
    check result.exitCode == 0
    let payload = parseJson(result.stdout)
    check payload["family"].getStr == "data_processing"
    check payload["rendererKey"].getStr == "nim.classic.data-processing"
    check payload["events"].len == 3
    for idx, event in payload["events"].getElems.pairs:
      check event["sequence"].getInt == idx + 1
      check event.hasKey("eventType")
      check event.hasKey("message")
      check event.hasKey("timestamp")
      check event.hasKey("context")

  test "modern-core family is deterministic for identical seeds":
    let first = runApp(@["--focus-family", "platform_engineering",
        "--output-format", "json", "--seed", "same-seed"])
    let second = runApp(@["--focus-family", "platform_engineering",
        "--output-format", "json", "--seed", "same-seed"])
    check first.exitCode == 0
    check second.exitCode == 0
    check first.stdout == second.stdout

  test "experimental provider fails fast":
    let result = runApp(@["--experimental-provider", "openai-compatible"])
    check result.exitCode == 2
    check "experimental-provider is not implemented yet in nim-stakeholder" in result.stderr
