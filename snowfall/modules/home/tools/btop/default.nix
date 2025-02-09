{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.btop;
in {
  options.${namespace}.tools.btop = with types; {
    enable = mkEnableOption "btop";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
    };
  };
}
