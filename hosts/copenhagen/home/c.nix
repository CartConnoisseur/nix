{ config, lib, pkgs, inputs, ...}:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ../../../roles/home
  ];

  home.roles = {
    dev = {
      enable = true;
      key = "DE64538967CA0C68";
    };
  };

  home.stateVersion = "23.11";
}
