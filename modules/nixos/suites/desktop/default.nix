{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.desktop;
in {
  options.${namespace}.suites.desktop = with types; {
    enable = mkEnableOption "desktop";
  };

  config = mkIf cfg.enable {
    cxl = {
      hardware = {
        audio.enable = true;
        rgb = {
          enable = true;
          headphones = true;
        };
      };

      apps = {
        i3.enable = true;
        playerctl.enable = true;
      };

      system.fonts.enable = true;
    };

    programs.dconf.enable = true;
  };
}
