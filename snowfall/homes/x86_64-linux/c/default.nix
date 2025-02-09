{ config, lib, namespace, ... }:

with lib; with lib.${namespace}; {
  cxl = {
    desktop.background = "shinobu.png";

    suites = {
      common.enable = true;
      desktop.enable = true;
      dev.enable = true;
      media.enable = true;
      gaming.enable = true;
      misc.enable = true;
    };

    apps = {
      discord.enable = true;
      gimp.enable = true;
      qbittorrent.enable = true;
      nicotine.enable = true;

      prismlauncher.extra.rusherhack.enable = true;
    };

    tools.git = {
      name = "Caroline Larimore";
      email = "caroline@larimo.re";
      key = "314C14641E707B68";
    };
  };

  home.stateVersion = "23.11";
}
