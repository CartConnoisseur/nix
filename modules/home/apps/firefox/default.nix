{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.firefox;
  impermanence = config.${namespace}.impermanence;
in {
  options.${namespace}.apps.firefox = with types; {
    enable = mkEnableOption "firefox";
  };

  config = mkIf cfg.enable {
    #TODO: migrate to declarative config
    home.persistence.${impermanence.location} = {
      directories = [
        ".mozilla"
      ];
    };

    programs.firefox = {
      enable = true;
    };
  };
}
