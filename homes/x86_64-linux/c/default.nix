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
      anki.enable = true;
      obsidian.enable = true;

      prismlauncher.extra.rusherhack.enable = true;
    };

    tools.wine.enable = true;

    tools.git = {
      name = "Caroline Larimore";
      email = "caroline@larimo.re";
    };
  };

  home.stateVersion = "23.11";
}
