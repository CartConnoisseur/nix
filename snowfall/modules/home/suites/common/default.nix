{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.common;
in {
  options.${namespace}.suites.common = with types; {
    enable = mkEnableOption "common";
  };

  config = mkIf cfg.enable {
    cxl = {
      tools = {
        git.enable = true;
      };
    };
  };
}

