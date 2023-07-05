#!/bin/bash

directories=(
    /Library/Application Support
    /Library/LaunchAgents
    /Library/LaunchDaemons
    /Library/Frameworks
    /Library/Logs
    /Library/Preferences
    /Library/PrivilegedHelperTools
    ~/Library/Application Support
    ~/Library/Caches
    ~/Library/Containers
    ~/Library/LaunchAgents
    ~/Library/Logs
    ~/Library/Preferences
    ~/Library/Saved Application State
)

search_pattern="$1"

if [ -z "$search_pattern" ]; then
    echo "Usage: $0 <app name>"
    exit 1
fi

for dir in "${directories[@]}"; do
    find "$dir" -maxdepth 1 -iname "*$search_pattern*" \
      -type d -print0 | xargs -0 -I {} sh -c 'echo -e \
      "\n{}"; find "{}" -type f -iname "*$search_pattern*" \
      -print0 | xargs -0 grep -li "$0" /dev/null' "$search_pattern"
done
