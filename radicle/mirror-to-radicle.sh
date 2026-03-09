#!/bin/sh
# Mirror a Forgejo repo push to Radicle.
#
# Usage: mirror-to-radicle.sh <bare-repo-path> [<branch>]
#
# The script will:
# 1. Clone the bare repo to a working copy (or pull if already cloned)
# 2. If not yet initialized in Radicle, run `rad init`
# 3. Push the branch to Radicle
#
# Designed to be called from a Forgejo webhook or post-receive hook.
# All operations are non-fatal — Radicle mirroring should never block Forgejo.

set -e

BARE_REPO_PATH="$1"
BRANCH="${2:-main}"
MIRROR_DIR="/var/radicle-mirrors"

if [ -z "$BARE_REPO_PATH" ]; then
    echo "Usage: mirror-to-radicle.sh <bare-repo-path> [<branch>]"
    exit 1
fi

# Derive a stable working copy path from the bare repo path
# e.g. /forgejo-data/git/repositories/testuser/test-repo.git → /var/radicle-mirrors/testuser/test-repo
RELATIVE_PATH=$(echo "$BARE_REPO_PATH" | sed 's|.*/repositories/||' | sed 's|\.git$||')
WORK_DIR="$MIRROR_DIR/$RELATIVE_PATH"
REPO_NAME=$(basename "$RELATIVE_PATH")

mkdir -p "$(dirname "$WORK_DIR")"

if [ -d "$WORK_DIR/.git" ]; then
    # Working copy exists — pull latest
    echo "Radicle: Pulling latest for $RELATIVE_PATH..."
    cd "$WORK_DIR"
    git pull origin "$BRANCH" 2>&1 || {
        echo "Radicle: Pull failed (non-fatal)"
        exit 0
    }
else
    # First time — clone from bare repo
    echo "Radicle: Cloning $RELATIVE_PATH..."
    git clone "$BARE_REPO_PATH" "$WORK_DIR" 2>&1 || {
        echo "Radicle: Clone failed (non-fatal)"
        exit 0
    }
    cd "$WORK_DIR"
fi

# Initialize in Radicle if not already done
if ! git remote | grep -q '^rad$'; then
    echo "Radicle: Initializing $REPO_NAME in Radicle..."
    RAD_PASSPHRASE="" rad init --name "$REPO_NAME" --default-branch "$BRANCH" --public --no-confirm 2>&1
    # Init may fail if already initialized in Radicle storage — that's fine,
    # the rad remote should still be set up. If not, we can't proceed.
    if ! git remote | grep -q '^rad$'; then
        echo "Radicle: Init failed and no rad remote (non-fatal)"
        exit 0
    fi
fi

# Push to Radicle
echo "Radicle: Pushing $BRANCH to Radicle..."
git push rad "$BRANCH" 2>&1 || {
    echo "Radicle: Push failed (non-fatal)"
    exit 0
}

echo "Radicle: Mirror complete for $RELATIVE_PATH"
