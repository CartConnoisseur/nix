{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.bash;
in {
  options.${namespace}.tools.bash = with types; {
    enable = mkEnableOption "bash";
  };

  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
    };
  };
}
