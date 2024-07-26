{ config, pkgs, ... }:

{
  services.displayManager = {
    defaultSession = "none+i3";
  };

  services.xserver = {
    videoDrivers = [ "amdgpu" ];

    displayManager = {
      setupCommands = config.roles.desktop.setupCommands;
    };

    xkb.layout = "us";
#    xkb.options = "eurosign:e,caps:escape";
  };
}
