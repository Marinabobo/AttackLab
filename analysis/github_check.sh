#!/bin/bash
echo '=== gh ==='
if command -v gh >/dev/null 2>&1; then
  gh --version | head -1
  gh auth status 2>&1 || true
else
  echo NO_GH
fi
echo '=== env tokens ==='
for v in GH_TOKEN GITHUB_TOKEN GITLAB_TOKEN; do
  if [ -n "${!v}" ]; then echo "$v is set"; else echo "$v not set"; fi
done
echo '=== gh config ==='
ls -la "$HOME/.config/gh" 2>/dev/null || echo NO_GH_CONFIG
echo '=== ssh ==='
ls -la "$HOME/.ssh" 2>/dev/null || echo NO_SSH_DIR
echo '=== git config ==='
git config --global --list 2>/dev/null || true
echo '=== repo remote ==='
cd /mnt/c/Users/admin/Documents/deepseek-harness/default-workspace/AttackLab || exit 1
git remote -v
git branch --show-current
