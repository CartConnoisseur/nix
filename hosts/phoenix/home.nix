{ config, lib, pkgs, inputs, ...}:

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
      key = "46008DE7867DA084";
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
    pfetch

    qbittorrent
    jellyfin-media-player

    gimp

    obsidian
    prismlauncher
  ];

  home.stateVersion = "23.11";
}
