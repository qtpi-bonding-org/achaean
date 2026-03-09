FROM rust:1.85-bookworm AS builder

WORKDIR /build
COPY radicle-mirror/ .
RUN cargo build --release

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl xz-utils openssh-client git \
    && rm -rf /var/lib/apt/lists/*

# Install Radicle from official release
RUN curl -sSLf https://radicle.xyz/install | sh

# Copy the mirror service binary
COPY --from=builder /build/target/release/radicle-mirror /usr/local/bin/radicle-mirror

ENV PATH="/root/.radicle/bin:${PATH}"
ENV RAD_HOME="/root/.radicle"

# 8776 = radicle node, 8080 = mirror webhook
EXPOSE 8776 8080

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
