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

    apps.i3 = {
      videoDrivers = [ "amdgpu" ];
      setupCommands = ''
        if ${pkgs.xorg.xrandr}/bin/xrandr --query | grep 2560x1080; then
          ${pkgs.xorg.xrandr}/bin/xrandr --output DVI-D-0 --mode 1920x1080  --rate 60  --pos 0x0
          ${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-2 --mode 2560x1080  --rate 60  --pos 1920x0 --primary
          ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-0 --mode 1920x1080  --rate 75  --pos 4480x0
        elif ${pkgs.xorg.xrandr}/bin/xrandr --query | grep 2560x1440; then
          ${pkgs.xorg.xrandr}/bin/xrandr --output DVI-D-0 --mode 1920x1080 --rate 60 --pos 0x360
          ${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-2 --mode 2560x1440 --rate 165 --pos 1920x0 --primary
          ${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-1 --mode 1920x1200 --rate 60 --pos 4480x0
        fi
      '';
    };
  };

  system.stateVersion = "23.11";
}
