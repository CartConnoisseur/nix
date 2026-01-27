{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.gaming;
  desktop = config.${namespace}.desktop;
in {
  options.${namespace}.suites.gaming = with types; {
    enable = mkEnableOption "gaming";
  };

  config = mkIf (cfg.enable && desktop.enable) {
    cxl = {
      apps = {
        steam.enable = true;
        prismlauncher.enable = true;
        lutris.enable = true;
        hytale.enable = true;
      };
    };
  };
}
