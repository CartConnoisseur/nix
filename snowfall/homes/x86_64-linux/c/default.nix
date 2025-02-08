{ lib, namespace, ... }:

with lib; with lib.${namespace}; {
  cxl = {
    suites = {
      common.enable = true;
      desktop.enable = true;
      dev.enable = true;
    };

    desktop.background = "shinobu.png";

    tools.git = {
      name = "Caroline Larimore";
      email = "caroline@larimo.re";
      key = "314C14641E707B68";
    };
  };

  home.stateVersion = "23.11";
}

