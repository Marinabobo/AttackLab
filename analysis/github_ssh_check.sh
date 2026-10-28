#!/bin/bash
echo '=== ssh auth ==='
ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new -T git@github.com 2>&1 || true
echo
echo '=== try known repo names ==='
for repo in AttackLab attacklab ICS-26Fall-FDU-AttackLab lab3-attacklab; do
  echo "--- Marinabobo/$repo ---"
  timeout 20 git ls-remote "git@github.com:Marinabobo/$repo.git" 2>&1 | head -5 || true
done
echo
echo '=== public key ==='
cat "$HOME/.ssh/id_ed25519.pub"
