{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.desktop;
  desktop = config.${namespace}.desktop;
in {
  options.${namespace}.suites.desktop = with types; {
    enable = mkEnableOption "desktop";
  };

  config = mkIf (cfg.enable && desktop.enable) {
    cxl = {
      apps = {
        kitty.enable = true;
        flameshot.enable = true;
        firefox.enable = true;
      };

      tools = {
        mute.enable = true;
      };

      desktop.components = {
        i3.enable = true;

        polybar.enable = true;
        rofi.enable = true;
        picom.enable = true;
        eww.enable = true;

        gtk.enable = true;
        fcitx5.enable = true;
      };
    };
  };
}
