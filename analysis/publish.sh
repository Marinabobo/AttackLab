#!/bin/bash
set -e
export PATH="$HOME/.local/bin:$PATH"
cd /mnt/c/Users/admin/Documents/deepseek-harness/default-workspace/AttackLab

echo '=== github identity ==='
gh api user --jq '.login, .name, .id' || true

echo '=== local changes ==='
git status --short

git config user.name "许波婧"
git config user.email "3514551168@qq.com"

git add -A
git status --short

if git diff --cached --quiet; then
  echo 'nothing to commit'
else
  git commit -m "Complete Lab3 AttackLab: four exploits and report"
fi

echo '=== remotes before ==='
git remote -v
git remote remove origin 2>/dev/null || true
git remote remove upstream 2>/dev/null || true

echo '=== create public repo and push ==='
gh repo create AttackLab \
  --public \
  --description "FDU ICS 2026 Fall Lab3 AttackLab - four exploits and report" \
  --source=. \
  --remote=origin \
  --push

echo '=== remotes after ==='
git remote -v
git log --oneline -3
