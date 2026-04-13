FROM debian:bookworm-slim AS build
RUN apt-get update \
  && apt-get install -y --no-install-recommends build-essential ca-certificates nim \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY nim_stakeholder.nimble ./
COPY src ./src
COPY tests ./tests
RUN nim check src/stakeholder.nim \
  && nim check --path:src tests/test_stakeholder.nim \
  && nimble test -y \
  && nim c -d:release -o:/opt/nim-stakeholder src/stakeholder.nim

FROM debian:bookworm-slim
RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates \
  && rm -rf /var/lib/apt/lists/*
COPY --from=build /opt/nim-stakeholder /usr/local/bin/nim-stakeholder
ENTRYPOINT ["/usr/local/bin/nim-stakeholder"]
