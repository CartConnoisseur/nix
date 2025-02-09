{ lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; {
  imports = with pkgs; [
    (mkSimpleApp "gimp" {})
    (mkSimpleApp "qbittorrent" {
      persist = [
        ".config/qBittorrent"
        ".local/share/qBittorrent"
        ".cache/qBittorrent"
      ];
    })
    (mkSimpleApp "nicotine" {
      packages = [ nicotine-plus ];
      persist = [
        ".config/nicotine"
        ".local/share/nicotine"
      ];
    })
  ];
}
