#!/bin/bash

REPO_PATHS=(
  "/home/reuben/Documents/Obsidian"
  "/home/reuben/cs"
)
UPDATED_REPOS=()
UNCHANGED_REPOS=()

notify_std() {
  local MESSAGE=$1
  notify-send " Sync" "$MESSAGE" -h string:x-canonical-private-synchronous:git-sync &
}

sync_repo() {
  local REPO_PATH=$1
  cd "$REPO_PATH" || {
    echo "Directory $REPO_PATH does not exist."
    notify-send " Sync" "Directory $REPO_PATH does not exist" -u critical
    return
  }

  if git diff-index --quiet HEAD --; then
    UNCHANGED_REPOS+=("$REPO_PATH")
    return
  fi

  TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")
  git add .
  git commit -m "Auto Commit on $TIMESTAMP"
  git push
  UPDATED_REPOS+=("$REPO_PATH")
}

for REPO_PATH in "${REPO_PATHS[@]}"; do
  sync_repo "$REPO_PATH"
  notify_std "Syncing $REPO_PATH"
done

RESULT_MESSAGE=""
if [ ${#UPDATED_REPOS[@]} -gt 0 ]; then
  RESULT_MESSAGE+="Updated:\n$(printf "%s\n" "${UPDATED_REPOS[@]}")\n"
fi
if [ ${#UNCHANGED_REPOS[@]} -gt 0 ]; then
  RESULT_MESSAGE+="Unchanged:\n$(printf "%s\n" "${UNCHANGED_REPOS[@]}")\n"
fi
if [ -z "$RESULT_MESSAGE" ]; then
  RESULT_MESSAGE="No valid repositories."
fi

notify_std "$RESULT_MESSAGE"
