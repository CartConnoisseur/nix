{ lib, pkgs, inputs, config, ...}:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ./modules/home
  ];

  # theme.nix is a symlink to a theme under ./themes/
  # This lets me switch out my theme while only altering
  #   theme.nix, which I dont commit changes to.
  theme = import ./theme.nix;

  home.stateVersion = "23.11";

  home.persistence."/persist/home" = {
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
      ".wine"

      ".irssi"      
      ".config/discord"
      ".config/Vencord"

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
    files = [
      ".Xresources"
    ];
    allowOther = true;
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
    (writeShellScriptBin "switch-theme"''
      #!/usr/bin/env bash

      cd /etc/nixos

      rm theme.nix
      ln -s ./themes/$1.nix theme.nix

      sudo nixos-rebuild switch --flake /etc/nixos#default

      i3-msg restart
    '')

    pfetch

    kdePackages.breeze

    irssi

    qbittorrent
    nicotine-plus
    jellyfin-media-player
    mkvtoolnix

    gimp

    anki-bin

    vesktop

    obsidian
    prismlauncher

    jetbrains.idea-community
  ];

  home.file = {
    ".0b".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/PrismLauncher/instances/0b/.minecraft";
  };
}
