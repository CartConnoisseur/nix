{ lib, namespace, ... }:

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
  };

  system.stateVersion = "23.11";
}
