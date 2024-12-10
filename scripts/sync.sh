#!/bin/bash

REPO_PATHS=(
  "/home/reuben/Documents/Obsidian"
  "/home/reuben/cs"
)

sync_repo() {
  local REPO_PATH=$1
  cd "$REPO_PATH" || {
    echo "Directory $REPO_PATH does not exist."
    return
  }

  if git diff-index --quiet HEAD --; then
    echo "No changes to commit in $REPO_PATH."
    return
  fi

  TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")
  git add .
  git commit -m "Auto Commit on $TIMESTAMP"
  git push
  notify-send " Sync" "Successfully synced $REPO_PATH at $TIMESTAMP"
}

for REPO_PATH in "${REPO_PATHS[@]}"; do
  sync_repo "$REPO_PATH"
done
