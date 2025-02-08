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
      ".local/bin"
      ".local/share/applications"

      ".mozilla"
      ".wine"

      ".irssi"

      ".config/Obsidian"

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

      ".config/nicotine"
      ".local/share/nicotine"
    ];
  };

  programs = {
    feh.enable = true;
    btop.enable = true;
    tmux.enable = true;

    zoxide.enable = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "obsidian"
  ];

  home.packages = with pkgs; [
    pfetch

    irssi

    qbittorrent
    nicotine-plus
    jellyfin-media-player
    mkvtoolnix

    gimp

    anki-bin

    obsidian

    #TODO: latest update broke
    # jetbrains.idea-community
  ];

  home.stateVersion = "23.11";
}
