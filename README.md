# dkb — Disk bars (FR/EN, mergerfs)

Affiche des barres de remplissage par **disque physique** et par **mount mergerfs**, avec détection auto de la locale :
- FR ⇒ titres en français, unités **To/Go**, virgule décimale
- EN ⇒ titres en anglais, unités **TB/GB**, point décimal
Tailles < 1 TB affichées en **Go/GB**.

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
LC_ALL=C dkb
LC_ALL=fr_FR.UTF-8 dkb
```

## Exigences
- jq, util-linux (lsblk/df), bash

## Licence
MIT
