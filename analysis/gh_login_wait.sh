#!/bin/bash
export PATH="$HOME/.local/bin:$PATH"
printf '\n' | gh auth login --hostname github.com --git-protocol ssh --web
echo "LOGIN_EXIT=$?"
