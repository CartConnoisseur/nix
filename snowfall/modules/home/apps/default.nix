{ lib, namespace, ... }:

with lib; with lib.${namespace}; {
  imports = [
    (mkSimpleApp "qbittorrent" {
      persist = [
        ".config/qBittorrent"
        ".local/share/qBittorrent"
        ".cache/qBittorrent"
      ];
    })
  ];
}
