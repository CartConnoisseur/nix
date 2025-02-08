{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.misc;
in {
  options.${namespace}.suites.misc = with types; {
    enable = mkEnableOption "misc";
  };

  config = mkIf cfg.enable {
    cxl = {
      apps = {
        fastfetch.enable = true;
      };
    };
  };
}
