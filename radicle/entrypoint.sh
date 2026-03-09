#!/bin/sh
set -e

# Allow reading Forgejo's bare repos (different ownership)
git config --global --add safe.directory "*"

# Create mirrors directory
mkdir -p /var/radicle-mirrors

# Initialize node identity if not already done
if [ ! -f "$RAD_HOME/keys/radicle.pub" ]; then
    echo "Initializing Radicle node identity..."
    RAD_PASSPHRASE="" rad auth --alias achaean-node
    echo "Node identity created."
fi

echo "Starting Radicle node..."
radicle-node --listen 0.0.0.0:8776 &

# Wait for node to be ready
sleep 2

echo "Starting radicle-mirror webhook service..."
exec radicle-mirror
