{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.desktop;
in {
  options.${namespace}.suites.desktop = with types; {
    enable = mkEnableOption "desktop";
  };

  config = mkIf cfg.enable {
    cxl = {
      apps = {
        i3.enable = true;
        kitty.enable = true;
      };
    };
  };
}
