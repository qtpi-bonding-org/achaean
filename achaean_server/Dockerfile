# Build stage — must build from repo root for workspace path dependencies
FROM dart:3.9 AS build
WORKDIR /app

# Copy trimmed workspace config (excludes Flutter packages)
COPY achaean_server/pubspec.docker.yaml pubspec.yaml

# Copy all workspace packages needed by achaean_server
COPY dart_git/ dart_git/
COPY dart_koinon/ dart_koinon/
COPY achaean_client/ achaean_client/
COPY koinon_index_core/koinon_index_core_server/ koinon_index_core/koinon_index_core_server/
COPY koinon_index_core/koinon_index_core_client/ koinon_index_core/koinon_index_core_client/
COPY koinon_index_content/koinon_index_content_server/ koinon_index_content/koinon_index_content_server/
COPY koinon_index_content/koinon_index_content_client/ koinon_index_content/koinon_index_content_client/
COPY achaean_server/ achaean_server/

# Resolve dependencies and compile
RUN cd achaean_server && dart pub get
RUN cd achaean_server && dart compile exe bin/main.dart -o bin/server

# Final stage
FROM alpine:latest

# Environment variables
ENV runmode=staging
ENV serverid=default
ENV logging=normal
ENV role=monolith

# Copy runtime dependencies
COPY --from=build /runtime/ /

# Copy compiled server executable
COPY --from=build /app/achaean_server/bin/server server

# Copy configuration files and resources
COPY --from=build /app/achaean_server/config/ config/
COPY --from=build /app/achaean_server/web/ web/
COPY --from=build /app/achaean_server/migrations/ migrations/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/achaean_server/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Define the entrypoint command
ENTRYPOINT ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role --apply-migrations
