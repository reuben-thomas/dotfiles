#!/usr/bin/env bash
set -e

REPO_URL="$1"
NAME="$2"

mkdir "$NAME" && cd "$NAME"
git clone --bare "$REPO_URL" "$NAME"
cd "$NAME"
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch origin
cd ..
git -C "$NAME" worktree add ../main main
