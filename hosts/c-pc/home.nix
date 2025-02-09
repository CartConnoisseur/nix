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
      ".config/jellyfin"
      ".local/share/jellyfin"
      ".cache/jellyfin"
    ];
  };

  home.packages = with pkgs; [
    mkvtoolnix
  ];

  home.stateVersion = "23.11";
}
