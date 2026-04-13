import std/[json, sequtils, strformat, strutils]

type
  OutputFormat* = enum
    outputText,
    outputJson

  FamilySpec* = object
    name*: string
    rendererKey*: string
    parityClass*: string
    phase*: string
    summary*: string
    rustPath*: string
    javaPath*: string
    contractPath*: string

  AppResult* = object
    exitCode*: int
    stdout*: string
    stderr*: string

const DedicatedFamilies* = [
  FamilySpec(name: "code_analyzer", rendererKey: "nim.classic.code-analyzer",
      parityClass: "dedicated-classic-six", phase: "classic-six",
      summary: "Inspect source layout, flag deterministic hotspots, and surface review-ready notes.",
      rustPath: "rust-stakeholder/src/generators/code_analyzer.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/activities/Activities.java:14",
      contractPath: "stakeholder-core/docs/generator-source-map.md"),
  FamilySpec(name: "data_processing", rendererKey: "nim.classic.data-processing",
      parityClass: "dedicated-classic-six", phase: "classic-six",
      summary: "Shape fixture data into stable batches and deterministic summary checkpoints.",
      rustPath: "rust-stakeholder/src/generators/data_processing.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/Main.java:15",
      contractPath: "stakeholder-core/docs/generator-source-map.md"),
  FamilySpec(name: "jargon", rendererKey: "nim.classic.jargon",
      parityClass: "dedicated-classic-six", phase: "classic-six",
      summary: "Translate specialist wording into shared operational vocabulary without losing intent.",
      rustPath: "rust-stakeholder/src/generators/jargon.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/config/ConfigTypes.java:6",
      contractPath: "stakeholder-core/docs/generator-source-map.md"),
  FamilySpec(name: "metrics", rendererKey: "nim.classic.metrics",
      parityClass: "dedicated-classic-six", phase: "classic-six",
      summary: "Render stable KPI checkpoints with deterministic sequence ordering.",
      rustPath: "rust-stakeholder/src/generators/metrics.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/config/SessionConfig.java:6",
      contractPath: "stakeholder-core/docs/generator-source-map.md"),
  FamilySpec(name: "network_activity", rendererKey: "nim.classic.network-activity",
      parityClass: "dedicated-classic-six", phase: "classic-six",
      summary: "Summarize edge and service traffic into reproducible transport notes.",
      rustPath: "rust-stakeholder/src/generators/network_activity.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRuntime.java:1",
      contractPath: "stakeholder-core/docs/generator-source-map.md"),
  FamilySpec(name: "system_monitoring", rendererKey: "nim.classic.system-monitoring",
      parityClass: "dedicated-classic-six", phase: "classic-six",
      summary: "Report deterministic runtime health and fail-fast telemetry checkpoints.",
      rustPath: "rust-stakeholder/src/generators/system_monitoring.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalStore.java:1",
      contractPath: "stakeholder-core/docs/generator-source-map.md"),
  FamilySpec(name: "agent_workflows", rendererKey: "nim.modern.agent-workflows",
      parityClass: "dedicated-modern-core", phase: "modern-core",
      summary: "Coordinate repeatable agent handoffs with explicit review and escalation markers.",
      rustPath: "rust-stakeholder/src/generators/agent_workflows.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalModels.java:1",
      contractPath: "stakeholder-core/docs/generator-families.md"),
  FamilySpec(name: "platform_engineering",
      rendererKey: "nim.modern.platform-engineering",
      parityClass: "dedicated-modern-core", phase: "modern-core",
      summary: "Describe platform rollout slices, controls, and deterministic release boundaries.",
      rustPath: "rust-stakeholder/src/generators/platform_engineering.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalDefaults.java:1",
      contractPath: "stakeholder-core/docs/generator-families.md"),
  FamilySpec(name: "observability_ai_runtime",
      rendererKey: "nim.modern.observability-ai-runtime",
      parityClass: "dedicated-modern-core", phase: "modern-core",
      summary: "Capture runtime inference signals and observability checkpoints with stable provenance.",
      rustPath: "rust-stakeholder/src/generators/observability_ai_runtime.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRequest.java:1",
      contractPath: "stakeholder-core/docs/generator-families.md"),
  FamilySpec(name: "delivery_preview_ops",
      rendererKey: "nim.modern.delivery-preview-ops",
      parityClass: "dedicated-modern-core", phase: "modern-core",
      summary: "Stage rollout previews, operator approvals, and go/no-go notes in deterministic order.",
      rustPath: "rust-stakeholder/src/generators/delivery_preview_ops.rs:1",
      javaPath: "java-stakeholder/src/test/java/com/stakeholder/experimental/ExperimentalRuntimeTest.java:1",
      contractPath: "stakeholder-core/docs/generator-families.md"),
  FamilySpec(name: "supply_chain_security",
      rendererKey: "nim.modern.supply-chain-security",
      parityClass: "dedicated-modern-core", phase: "modern-core",
      summary: "Track artifact integrity, dependency posture, and attestation checkpoints explicitly.",
      rustPath: "rust-stakeholder/src/generators/supply_chain_security.rs:1",
      javaPath: "java-stakeholder/src/test/java/com/stakeholder/experimental/ExperimentalLiveIntegrationTest.java:1",
      contractPath: "stakeholder-core/docs/generator-families.md")
]

const GroupedFallbackFamilies* = [
  FamilySpec(name: "ai_governance", rendererKey: "nim.grouped.ai-governance",
      parityClass: "grouped-fallback", phase: "post-modern-core",
      summary: "Grouped fallback until dedicated AI governance depth is promoted.",
      rustPath: "rust-stakeholder/src/generators/evaluation_and_guardrails.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRuntime.java:1",
      contractPath: "stakeholder-core/docs/generator-families.md"),
  FamilySpec(name: "security_blockchain",
      rendererKey: "nim.grouped.security-blockchain",
      parityClass: "grouped-fallback", phase: "post-modern-core",
      summary: "Grouped fallback until dedicated security and blockchain depth is promoted.",
      rustPath: "rust-stakeholder/src/generators/blockchain_protocol_ops.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRuntime.java:1",
      contractPath: "stakeholder-core/docs/generator-families.md"),
  FamilySpec(name: "health_protocol", rendererKey: "nim.grouped.health-protocol",
      parityClass: "grouped-fallback", phase: "post-modern-core",
      summary: "Grouped fallback until dedicated healthcare protocol depth is promoted.",
      rustPath: "rust-stakeholder/src/generators/hl7v2_feed_ops.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRuntime.java:1",
      contractPath: "stakeholder-core/docs/generator-families.md"),
  FamilySpec(name: "overlay_quantum", rendererKey: "nim.grouped.overlay-quantum",
      parityClass: "grouped-fallback", phase: "post-modern-core",
      summary: "Grouped fallback until dedicated overlay and quantum-adjacent depth is promoted.",
      rustPath: "rust-stakeholder/src/generators/proof_and_sequencer_ops.rs:1",
      javaPath: "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRuntime.java:1",
      contractPath: "stakeholder-core/docs/generator-families.md")
]

proc allFamilies*(): seq[FamilySpec] =
  result = @[]
  result.add(DedicatedFamilies)
  result.add(GroupedFallbackFamilies)

proc stableHash(input: string): int =
  var acc = 2166136261'u32
  for ch in input:
    acc = (acc xor uint32(ord(ch))) * 16777619'u32
  result = int(acc and 0x7fffffff'u32)

proc deterministicTimestamp(seed, family: string; sequence: int): string =
  let base = stableHash(seed & ":" & family)
  let day = (base mod 27) + 1
  let hour = (base div 7 + sequence * 3) mod 24
  let minute = (base div 13 + sequence * 11) mod 60
  result = &"2026-02-{day:02}T{hour:02}:{minute:02}:00Z"

proc traceNode(spec: FamilySpec): JsonNode =
  %*{
    "rustPath": spec.rustPath,
    "javaPath": spec.javaPath,
    "contractPath": spec.contractPath,
    "parityClass": spec.parityClass
  }

proc familyNode(spec: FamilySpec): JsonNode =
  %*{
    "family": spec.name,
    "rendererKey": spec.rendererKey,
    "phase": spec.phase,
    "parityClass": spec.parityClass,
    "summary": spec.summary,
    "sourceTrace": traceNode(spec)
  }

proc renderMessages(spec: FamilySpec; seed: string): array[3, string] =
  [
    &"[{spec.name}] open deterministic lane for seed {seed}",
    &"[{spec.name}] apply {spec.rendererKey} with source trace anchored to Rust and Java",
    &"[{spec.name}] emit review-ready summary for {spec.phase}"
  ]

proc renderEvent(spec: FamilySpec; seed: string; sequence: int; stage: string;
    message: string): JsonNode =
  %*{
    "eventType": stage,
    "sequence": sequence,
    "message": message,
    "timestamp": deterministicTimestamp(seed, spec.name, sequence),
    "context": {
      "family": spec.name,
      "rendererKey": spec.rendererKey,
      "phase": spec.phase,
      "seed": seed,
      "trace": traceNode(spec)
    }
  }

proc renderFamilyNode*(spec: FamilySpec; seed: string): JsonNode =
  let messages = renderMessages(spec, seed)
  %*{
    "family": spec.name,
    "rendererKey": spec.rendererKey,
    "phase": spec.phase,
    "parityClass": spec.parityClass,
    "seed": seed,
    "events": [
      renderEvent(spec, seed, 1, "session.start", messages[0]),
      renderEvent(spec, seed, 2, "session.signal", messages[1]),
      renderEvent(spec, seed, 3, "session.summary", messages[2])
    ]
  }

proc renderFamilyText(spec: FamilySpec; seed: string): string =
  let messages = renderMessages(spec, seed)
  result = @[
    &"family={spec.name}",
    &"rendererKey={spec.rendererKey}",
    &"phase={spec.phase}",
    &"parityClass={spec.parityClass}",
    &"seed={seed}",
    &"1|session.start|{messages[0]}",
    &"2|session.signal|{messages[1]}",
    &"3|session.summary|{messages[2]}"
  ].join("\n")

proc listValuesNode*(): JsonNode =
  let families = allFamilies().mapIt(familyNode(it))
  %*{
    "count": families.len,
    "families": families
  }

proc listValuesText(): string =
  allFamilies()
    .mapIt(&"{it.name}\t{it.rendererKey}\t{it.parityClass}\t{it.phase}")
    .join("\n")

proc findFamily(name: string): tuple[found: bool; spec: FamilySpec] =
  for spec in allFamilies():
    if cmpIgnoreCase(spec.name, name) == 0:
      return (true, spec)
  (false, FamilySpec())

proc usageText(): string =
  @[
    "nim-stakeholder",
    "  --list-values",
    "  --focus-family <family>",
    "  --output-format <text|json>",
    "  --seed <value>",
    "  --experimental-provider <name>"
  ].join("\n")

proc runApp*(args: seq[string]): AppResult =
  var listValues = false
  var focusFamily = ""
  var outputFormat = outputText
  var seed = "default-seed"
  var experimentalProvider = ""

  var index = 0
  while index < args.len:
    let current = args[index]
    case current
    of "--list-values":
      listValues = true
      inc index
    of "--focus-family":
      if index + 1 >= args.len:
        return AppResult(exitCode: 1, stderr: "missing value for --focus-family")
      focusFamily = args[index + 1]
      index += 2
    of "--output-format":
      if index + 1 >= args.len:
        return AppResult(exitCode: 1, stderr: "missing value for --output-format")
      let normalized = args[index + 1].toLowerAscii()
      if normalized == "json":
        outputFormat = outputJson
      elif normalized == "text":
        outputFormat = outputText
      else:
        return AppResult(exitCode: 1, stderr: &"unsupported output format: {args[index + 1]}")
      index += 2
    of "--seed":
      if index + 1 >= args.len:
        return AppResult(exitCode: 1, stderr: "missing value for --seed")
      seed = args[index + 1]
      index += 2
    of "--experimental-provider":
      if index + 1 >= args.len:
        return AppResult(exitCode: 1, stderr: "missing value for --experimental-provider")
      experimentalProvider = args[index + 1]
      index += 2
    of "--help", "-h":
      return AppResult(exitCode: 0, stdout: usageText())
    else:
      return AppResult(exitCode: 1, stderr: &"unexpected positional argument: {current}\n{usageText()}")

  if experimentalProvider.len > 0:
    return AppResult(exitCode: 2, stderr: &"experimental-provider is not implemented yet in nim-stakeholder: {experimentalProvider}")

  if listValues:
    if outputFormat == outputJson:
      return AppResult(exitCode: 0, stdout: $(listValuesNode()))
    return AppResult(exitCode: 0, stdout: listValuesText())

  if focusFamily.len == 0:
    return AppResult(exitCode: 1, stderr: &"missing required option: --focus-family\n{usageText()}")

  let match = findFamily(focusFamily)
  if not match.found:
    let known = allFamilies().mapIt(it.name).join(", ")
    return AppResult(exitCode: 1, stderr: &"unknown family: {focusFamily}; known families: {known}")

  if outputFormat == outputJson:
    return AppResult(exitCode: 0, stdout: $(renderFamilyNode(match.spec, seed)))
  AppResult(exitCode: 0, stdout: renderFamilyText(match.spec, seed))
