{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.gaming;
in {
  options.${namespace}.suites.gaming = with types; {
    enable = mkEnableOption "gaming";
  };

  config = mkIf cfg.enable {
    cxl = {
      apps = {
        steam.enable = true;
      };
    };
  };
}
