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
    (mkSimpleApp "anki" {
      packages = [ anki-bin ];
      persist = [ ".local/share/Anki2" ];
    })
    (mkSimpleApp "jellyfin" {
      packages = [ jellyfin-media-player ];
    })
    (mkSimpleApp "lutris" {
      persist = [ ".local/share/lutris" ];
    })
  ];
}
