{ lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; {
  imports = [
    ./hardware.nix
    ./network.nix
  ];

  cxl = {
    system = {
      hostname = "copenhagen";
      id = "a50062ff";
      
      impermanence.enable = true;
      impermanence.home.enable = true;
    };

    services = {
      web = {
        enable = true;
        images.enable = true;
        stargazers.enable = true;
      }
    }
  };

  system.stateVersion = "23.11";
}