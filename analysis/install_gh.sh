#!/bin/bash
set -e
mkdir -p "$HOME/.local/gh" "$HOME/.local/bin"
cd "$HOME/.local/gh"
curl -fL --retry 3 -o gh.tar.gz https://github.com/cli/cli/releases/download/v2.103.3/gh_2.103.3_linux_amd64.tar.gz
tar -xzf gh.tar.gz
ln -sf "$HOME/.local/gh/gh_2.103.3_linux_amd64/bin/gh" "$HOME/.local/bin/gh"
"$HOME/.local/bin/gh" --version
