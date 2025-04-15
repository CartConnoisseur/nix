{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.zoxide;
in {
  options.${namespace}.tools.zoxide = with types; {
    enable = mkEnableOption "zoxide";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
    };
  };
}
