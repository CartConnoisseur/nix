{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.git;
in {
  options.${namespace}.tools.git = with types; {
    enable = mkEnableOption "git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      prompt.enable = true;
    };
  };
}
