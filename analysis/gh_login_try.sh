#!/bin/bash
export PATH="$HOME/.local/bin:$PATH"
printf '\n' | timeout 25 gh auth login --hostname github.com --git-protocol ssh --web 2>&1
echo "EXIT=$?"
