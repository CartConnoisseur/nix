# NixOS Config
i honestly have no clue what im doing but its working ¯\\\_(ツ)_/¯

# Hosts
Each machine has its own config under [`hosts/`](hosts/) and enables various "[roles](roles/)"

## c-pc / default
Main desktop PC

### Disks / Partitions
See [Hardware Configuration](hosts/c-pc/hardware-configuration.nix)
- Main SSD
    - `boot` (fat32) -> `/boot`
    - `zpool` (zfs pool)
        - `root` -> `/`
        - `home` -> `/home`
        - `persist` -> `/persist`
        - `secure` (encrypted)
            - `secrets` -> `/secrets`
            - `persist` -> `/persist/secure`
        - `nix` -> `/nix`
- 4tb HDD
    - `4tb` (ext4) -> `/mnt/4tb`
- 256gb SSD
    - `ssd-256` (ext4) -> `/mnt/ssd`

## copenhagen
Home server

### Disks / Partitions
See [Hardware Configuration](hosts/copenhagen/hardware-configuration.nix)
- Main SSD
    - `boot` (fat32) -> `/boot`
    - `zpool` (zfs pool)
        - `root` -> `/`
        - `home` -> `/home`
        - `persist` -> `/persist`
        - `secrets` -> `/secrets`
        - `secure` (encrypted, unused)
        - `nix` -> `/nix`
- Old Server HDD
    - `boot` (fat32, unlabeled)
    - `box` (ext4) -> `/mnt/old`

## phoenix
Rarely-used laptop

### Disks / Partitions
See [Hardware Configuration](hosts/phoenix/hardware-configuration.nix)
- Main SSD
    - `boot` (fat32) -> `/boot`
    - `zpool` (zfs pool)
        - `root` -> `/`
        - `home` -> `/home`
        - `secure` (encrypted)
            - `nix` -> `/nix`
            - `persist` -> `/persist`
            - `secrets` -> `/secrets`
