{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.i3;
in {
  options.${namespace}.apps.i3 = with types; {
    enable = mkEnableOption "i3";

    videoDrivers = mkOption {
      type = types.listOf types.str;
      default = [ "modesetting" "fbdev" ];
    };
    
    setupCommands = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Shell commands executed just after the X server has started.
      '';
    };
  };

  config = mkIf cfg.enable {
    services = {
      displayManager = {
        enable = true;
        defaultSession = "none+i3";
      };

      xserver = {
        enable = true;
        windowManager.i3.enable = true;

        displayManager = {
          lightdm.enable = true;
          setupCommands = cfg.setupCommands;
        };

        videoDrivers = cfg.videoDrivers;
        xkb.layout = "us";
      };

      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad.naturalScrolling = true;
      };
    };
  };
}
