{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.web;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.web = with types; {
    enable = mkEnableOption "web";
  };

  config = mkIf cfg.enable {
    environment.persistence.${impermanence.location} = {
      directories = [
        "/var/lib/acme"
      ];
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "caroline@larimo.re";
    };
  };
}
