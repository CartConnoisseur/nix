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

      ".config/jellyfin"
      ".local/share/jellyfin"
      ".cache/jellyfin"
    ];
  };

  programs = {
    tmux.enable = true;

    zoxide.enable = true;
  };

  home.packages = with pkgs; [
    pfetch

    irssi

    mkvtoolnix
  ];

  home.stateVersion = "23.11";
}
