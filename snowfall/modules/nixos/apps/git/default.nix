{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.git;
in {
  options.${namespace}.apps.git = with types; {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.git.enable = true;
  };
}
