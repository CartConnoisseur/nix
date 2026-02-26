{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.web.cxl.sh;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.web.cxl.sh = with types; {
    enable = mkEnableOption "cxl.sh webserver";
  };

  config = mkIf cfg.enable {
    cxl.services.web.enable = true;

    environment.persistence.${impermanence.location} = {
      directories = [
        "/srv/web/cxl.sh"
      ];
    };
    
    services.nginx = {
      enable = true;
      virtualHosts = {
        "cxl.sh" = {
          addSSL = true;
          enableACME = true;

          root = "/srv/web/cxl.sh";
        };
      };
    };
  };
}
