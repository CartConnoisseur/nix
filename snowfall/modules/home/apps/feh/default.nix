{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.feh;
in {
  options.${namespace}.apps.feh = with types; {
    enable = mkEnableOption "feh";
  };

  config = mkIf cfg.enable {
    programs.feh = {
      enable = true;
    };
  };
}
