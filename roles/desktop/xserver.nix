{ config, pkgs, lib, ... }:

{
  services.displayManager = {
    defaultSession = "none+i3";
  };

  services.xserver = {
    videoDrivers = config.roles.desktop.videoDrivers;

    displayManager = {
      setupCommands = config.roles.desktop.setupCommands;
    };

    xkb.layout = "us";
#    xkb.options = "eurosign:e,caps:escape";
  };
}
