#!/bin/bash
echo '=== network ==='
curl -sS -I --max-time 20 https://github.com 2>&1 | head -3 || true
echo '=== latest gh ==='
curl -sS --max-time 30 https://api.github.com/repos/cli/cli/releases/latest 2>/dev/null | grep -m1 '"tag_name"' || echo NO_API
echo '=== sudo ==='
sudo -n true 2>&1 && echo SUDO_OK || echo NO_SUDO
echo '=== arch ==='
uname -m
