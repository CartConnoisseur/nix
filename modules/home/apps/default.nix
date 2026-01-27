{ lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; {
  imports = with pkgs; [
    (mkSimpleApp "gimp" { packages = [ gimp3 ]; })
    (mkSimpleApp "jellyfin" { packages = [ jellyfin-media-player ]; })
    
    (mkSimpleApp "lutris" { persist = [ ".local/share/lutris" ]; })
    (mkSimpleApp "hytale" {
      packages = [ hytale-launcher ];
      persist = [
        ".local/share/hytale-launcher"
        ".local/share/Hytale"
      ];
    })

    (mkSimpleApp "irssi" { persist = [ ".irssi" ]; })

    (mkSimpleApp "intellij" {
      packages = [ jetbrains.idea-oss ];
      persist = [
        ".config/JetBrains"
        ".local/share/JetBrains"
        ".cache/JetBrains"
      ];
    })

    (mkSimpleApp "anki" {
      packages = [ anki-bin ];
      persist = [ ".local/share/Anki2" ];
    })

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

    (mkSimpleApp "pfetch" {})
    (mkSimpleApp "cmatrix" {})
    (mkSimpleApp "asciiquarium" {})
    (mkSimpleApp "pipes" {})
    (mkSimpleApp "cowsay" {})
    (mkSimpleApp "figlet" {})
  ];
}
