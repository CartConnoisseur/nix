{ config, lib, pkgs, inputs, ...}:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ../../roles/home
  ];

  # theme.nix is an untracked symlink to a theme under ./themes/
  # This lets me switch out my theme without making changes in git
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
      
      ".local/bin"
      ".local/share/applications"

      ".mozilla"
      ".wine"

      ".irssi"      
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

      ".config/jellyfin"
      ".local/share/jellyfin"
      ".cache/jellyfin"

      ".local/share/Anki2"
      ".local/share/lutris"
      ".local/share/PrismLauncher"

      ".config/nicotine"
      ".local/share/nicotine"
    ];
  };

  home.persistence."/persist/secure/home" = {
    allowOther = true;

    directories = [
      ".gnupg"
      ".ssh"
    ];
  };

  home.roles = {
    dev = {
      enable = true;
      key = "314C14641E707B68";
    };

    desktop.enable = true;
  };

  programs = {
    feh.enable = true;
    btop.enable = true;
    tmux.enable = true;

    zoxide.enable = true;
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

      sudo nixos-rebuild switch --flake /etc/nixos#default

      i3-msg restart
    '')

    pfetch

    irssi

    qbittorrent
    nicotine-plus
    jellyfin-media-player
    mkvtoolnix

    gimp

    anki-bin

    obsidian
    prismlauncher

    #TODO: latest update broke
    # jetbrains.idea-community
  ];

  home.file = {
    ".0b".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/PrismLauncher/instances/0b/.minecraft";
  };

  home.stateVersion = "23.11";
}
