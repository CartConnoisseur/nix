{ lib, pkgs, inputs, config, ...}:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ../../roles/home
  ];
  
  theme = import ../../theme.nix;

  home.persistence."/persist/home" = {
    allowOther = true;

    directories = [
      "Downloads"
      "Documents"
      "Pictures"
      "Videos"
      "Music"
      "Games"
      "Persist"

      "code"

      ".gnupg"
      ".ssh"
      
      ".local/bin"
      ".local/share/applications"

      ".mozilla"

      ".config/discord"
      ".config/Vencord"
      ".config/vesktop"

      ".config/Obsidian"

      ".config/cmus"

      ".config/fcitx"
      ".config/fcitx5"
      
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }

      ".config/qBittorrent"
      ".local/share/qBittorrent"
      ".cache/qBittorrent"

      ".local/share/lutris"
      ".local/share/PrismLauncher"
    ];
  };

  home.roles = {
    dev = {
      enable = true;
      key = ""; #TODO: create signing key for phoenix
    };

    desktop.enable = true;
  };

  programs = {
    feh.enable = true;
    btop.enable = true;
    tmux.enable = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
    "obsidian"
  ];

  home.packages = with pkgs; [
    (writeShellScriptBin "switch-theme" ''
      #!/usr/bin/env bash

      cd /etc/nixos

      rm theme.nix
      ln -s ./themes/$1.nix theme.nix

      sudo nixos-rebuild switch --flake /etc/nixos

      i3-msg restart
    '')

    pfetch

    qbittorrent
    jellyfin-media-player

    gimp

    obsidian
    prismlauncher

    cloc
  ];

  home.stateVersion = "23.11";
}
