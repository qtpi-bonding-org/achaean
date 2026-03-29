#!/bin/sh
# Run Flutter web on a fixed port for OAuth redirect URI stability.
# Uses incognito to avoid stale secure storage / session state.
# Usage: ./scripts/flutter-web.sh
cd "$(dirname "$0")/../achaean_flutter" && flutter run -d chrome --web-port=59480 --web-browser-flag="--incognito" "$@"
