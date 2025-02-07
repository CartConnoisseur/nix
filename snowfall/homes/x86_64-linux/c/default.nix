{ lib, namespace, ... }:

with lib; with lib.${namespace}; {
  cxl = {
    desktop.background = "shinobu.png";
  };

  home.stateVersion = "23.11";
}
