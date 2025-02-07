{ lib, namespace, ... }:

with lib; with lib.${namespace}; {
  cxl = {
    desktop.background = "shinobu.png";
    suites.desktop.enable = true;
  };

  home.stateVersion = "23.11";
}
