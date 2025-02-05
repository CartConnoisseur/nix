{ lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; {
  imports = [
    ./hardware.nix
    ./network.nix
  ];
  
  cxl = {
    system = {
      hostname = "c-pc";
      id = "23ce94ff";
    };

    suites = {
      common.enable = true;
      desktop.enable = true;
    };

    fonts.extra = with pkgs; [
      minecraftia
    ];
  };

  system.stateVersion = "23.11";
}
