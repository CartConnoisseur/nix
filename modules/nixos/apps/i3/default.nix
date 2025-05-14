{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.i3;
in {
  options.${namespace}.apps.i3 = with types; {
    enable = mkEnableOption "i3";
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
        displayManager.lightdm.enable = true;

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
