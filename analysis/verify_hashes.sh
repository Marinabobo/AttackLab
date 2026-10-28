#!/bin/bash
cd "$(dirname "$0")/.."
sha256sum attack/dark-calc attack/dark-calc-nx attack/dark-log attack/malware
echo '--- expected ---'
cat <<'EOF'
a9c3d4a5eed6a937e85884f6a53faa39613d49e04792e2c411620fcc74f79097  attack/dark-calc
86c2c8dfaf4a89eb7a1396d9731bfb7ee085f0b45c86687b41547a30b5b1c613  attack/dark-calc-nx
9a4479f2a522d377055b54d328d5c0e0f3ca1327708ac792028ec03cadaee31d  attack/dark-log
03289add49f13e8573d125c8949bd88c9892e84f205802613a6baa2318fb18bc  attack/malware
EOF
