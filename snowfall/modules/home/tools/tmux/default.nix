{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.tmux;
in {
  options.${namespace}.tools.tmux = with types; {
    enable = mkEnableOption "tmux";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
    };
  };
}
