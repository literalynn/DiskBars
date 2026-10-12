#!/usr/bin/env bash
# Runs dkb against fake lsblk/df output and checks what it prints.
set -euo pipefail
cd "$(dirname "$0")"
stub=$(mktemp -d); trap 'rm -rf "$stub"' EXIT

cat >"$stub/lsblk" <<'EOF'
#!/bin/sh
cat <<'JSON'
{"blockdevices":[
  {"name":"sda","type":"disk","size":12000000000000,"model":"TOSHIBA MG07","fsused":null,
   "children":[{"name":"sda1","type":"part","size":12000000000000,"fsused":"7860000000000"}]},
  {"name":"sdb","type":"disk","size":1000000000000,"model":null,"fsused":null,
   "children":[{"name":"sdb1","type":"part","size":1000000000000,"fsused":11000000000}]},
  {"name":"md","type":"disk","size":1000000000,"model":"raid","fsused":2000000000},
  {"name":"loop0","type":"loop","size":1000,"model":null,"fsused":1000}
]}
JSON
EOF
cat >"$stub/df" <<'EOF'
#!/bin/sh
printf '%s\n' 'Filesystem Type 1B-blocks Used Available Capacity Mounted on' \
  'all:storage fuse.mergerfs 20000000000000 12000000000000 8000000000000 60% /mnt/storage' \
  '/dev/sda1 ext4 12000000000000 7860000000000 4140000000000 66% /mnt/disk1'
EOF
chmod +x "$stub"/*

run() { PATH="$stub:$PATH" LC_ALL="$1" ./dkb 10 | sed 's/\x1b\[[0-9;]*m//g'; }
check() { grep -qF -- "$2" <<<"$1" || { echo "FAIL: missing '$2' in:"; echo "$1"; exit 1; } >&2; }

en=$(run C.UTF-8)
check "$en" 'sda  12TB  TOSHIBA MG07'
check "$en" '[██████░░░░]  65.5%  (7.9 TB/12.0 TB)'
check "$en" 'Unknown'
check "$en" '(11.0 GB/1.0 TB)'          # small usage on a big disk stays readable
check "$en" '[██████████] 200.0%'       # bar never grows past its width
check "$en" 'storage  20TB  mergerfs  [██████░░░░]  60.0%'
grep -q loop0 <<<"$en" && { echo "FAIL: loop device listed" >&2; exit 1; }

fr=$(run fr_FR.UTF-8)
check "$fr" '=== Disques physiques ==='
check "$fr" '65,5%  (7,9 To/12,0 To)'

./dkb abc 2>/dev/null && { echo "FAIL: bad width accepted" >&2; exit 1; }
echo "all tests passed"
