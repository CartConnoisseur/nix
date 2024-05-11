{ lib, pkgs, inputs, config, ...}:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ./modules/home
  ];

  theme = import ./themes/skull.nix;

  home.stateVersion = "23.11";

  home.persistence."/persist/home" = {
    directories = [
      "Downloads"
      "Documents"
      "Pictures"
      "Videos"
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

      ".config/eww"
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
    eww
    pfetch

    kdePackages.breeze

    irssi
    (discord.override {
      withVencord = true;
    })

    qbittorrent
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
