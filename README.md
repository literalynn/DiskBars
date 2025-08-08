# dkb — Disk bars viewer

```bash
$ dkb
=== Disques physiques ===
sda  12To  TOSHIBA MG07ACA12TE        [██████████████████░░░░░░░░░░░░]  61,8%  (7,4 To/12,0 To)
sdb  14To  ST14000NM001G              [█████████████████░░░░░░░░░░░░░]  59,5%  (8,3 To/14,0 To)
sdc   8To  WDC WD80EFZZ               [█████████████░░░░░░░░░░░░░░░░░]  45,2%  (3,6 To/8,0 To)
sdd  18To  TOSHIBA MG09ACA18TE        [██████████░░░░░░░░░░░░░░░░░░░░]  34,2%  (6,2 To/18,0 To)
sde  10To  WDC WD101EFBX              [████████████████████████████░░]  94,2%  (9,4 To/10,0 To)
sdf 500Go  Samsung SSD 870 EVO 500GB  [████████████░░░░░░░░░░░░░░░░░░]  42,3%  (211,4 Go/500,1 Go)

=== MergerFS ===
pool   62To  mergerfs  [████████████████░░░░░░░░░░░░░░]  56,4%  (34,8 To/61,7 To)
media  26To  mergerfs  [██████████████████░░░░░░░░░░░░]  60,4%  (15,7 To/26,0 To)
```

## Installation (1-ligne)
```bash
sudo apt update && sudo apt install -y jq curl \
&& sudo curl -fsSL https://raw.githubusercontent.com/literalynn/dkb/main/dkb -o /usr/local/bin/dkb \
&& sudo chmod +x /usr/local/bin/dkb && dkb
```

## Usage
```bash
dkb
dkb 50
```

## Exigences
- jq, util-linux (lsblk/df), bash

## Licence
MIT
