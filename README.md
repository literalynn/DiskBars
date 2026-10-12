# DiskBars

`dkb` is a small Bash script that shows how full your disks are as bars in the terminal.
It's built for homelab servers with lots of drives and MergerFS pools.

```console
$ dkb
=== Physical disks ===
sda  12TB  TOSHIBA MG07ACA12TE        [██████████████████░░░░░░░░░░░░]  61.8%  (7.4 TB/12.0 TB)
sdb  14TB  ST14000NM001G              [█████████████████░░░░░░░░░░░░░]  59.5%  (8.3 TB/14.0 TB)
sdc   8TB  WDC WD80EFZZ               [█████████████░░░░░░░░░░░░░░░░░]  45.2%  (3.6 TB/8.0 TB)
sdd  18TB  TOSHIBA MG09ACA18TE        [██████████░░░░░░░░░░░░░░░░░░░░]  34.2%  (6.2 TB/18.0 TB)
sde  10TB  WDC WD101EFBX              [████████████████████████████░░]  94.2%  (9.4 TB/10.0 TB)
sdf 500GB  Samsung SSD 870 EVO 500GB  [████████████░░░░░░░░░░░░░░░░░░]  42.3%  (211.4 GB/500.1 GB)

=== MergerFS mounts ===
pool   62TB  mergerfs  [████████████████░░░░░░░░░░░░░░]  56.4%  (34.8 TB/61.7 TB)
media  26TB  mergerfs  [██████████████████░░░░░░░░░░░░]  60.4%  (15.7 TB/26.0 TB)
```

## Features

- One line per physical disk with its size, model, a usage bar and used/total space
- MergerFS pools in a separate section
- English or French output, based on your locale
- One file, no root needed, only depends on `jq`

## Install

```bash
sudo apt install -y jq curl
sudo curl -fsSL https://raw.githubusercontent.com/literalynn/DiskBars/main/dkb -o /usr/local/bin/dkb
sudo chmod +x /usr/local/bin/dkb
```

On other distros, install `jq` with your package manager. `lsblk` and `df` are already there.

## Usage

```bash
dkb       # 30-character bars
dkb 50    # wider bars
```

## How it works

- **Physical disks**: `lsblk` lists the disks, and the used space of a disk is the sum of the used space of every mounted filesystem on it. Unmounted partitions count as empty.
- **MergerFS**: sizes come straight from `df` for every `fuse.mergerfs` mount.

## Tests

```bash
./test.sh
```

This runs `dkb` against fake `lsblk` and `df` output, so it works on any machine.

## License

[MIT](LICENSE)
