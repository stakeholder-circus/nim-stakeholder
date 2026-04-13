import std/[os, strutils]
import stakeholder_runtime

when isMainModule:
  let result = runApp(commandLineParams())
  if result.stdout.len > 0:
    stdout.write(result.stdout)
    if not result.stdout.endsWith("\n"):
      stdout.write("\n")
  if result.stderr.len > 0:
    stderr.write(result.stderr)
    if not result.stderr.endsWith("\n"):
      stderr.write("\n")
  quit(result.exitCode)
