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
      ssh = {
        enable = true;
        port = 42069;
      };

      web = {
        personal.enable = true;
        landing.enable = true;
        images.enable = true;
        stargazers.enable = true;
      };

      minecraft = {
        stargazers = {
          enable = true;
          port = 25566;
        };
        
        zenith = {
          enable = true;
          port = 25569;
        };
      };
    };
  };

  system.stateVersion = "23.11";
}