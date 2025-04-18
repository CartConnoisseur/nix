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
      
      impermanence.enable = true;
      impermanence.home.enable = true;

      fonts.nerdfonts = true;
      fonts.extra = with pkgs; [
        minecraftia
      ];
    };

    suites = {
      common.enable = true;
      desktop.enable = true;
      gaming.enable = true;
    };

    apps.i3 = {
      videoDrivers = [ "amdgpu" ];
      #TODO: migrate to services.autorandr
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

  services = {
    printing.enable = true;
    hardware.openrgb.enable = true;
    udev.enable = true;
  };

  snowfallorg.users."c" = {
    admin = true;

    home.config = {
      cxl = {
        desktop.enable = true;
        tools.git.key = "314C14641E707B68";
      };
    };
  };

  users.users = {
    root.hashedPasswordFile = "/secrets/passwords/root";
    "c".hashedPasswordFile = "/secrets/passwords/c";
  };

  system.stateVersion = "23.11";
}
