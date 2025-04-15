{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.web.landing;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.web.landing = with types; {
    enable = mkEnableOption "cxl.sh landing page webserver";
  };

  config = mkIf cfg.enable {
    cxl.services.web.enable = true;

    environment.persistence.${impermanence.location} = {
      directories = [
        "/srv/web/landing"
      ];
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];
    
    services.nginx = {
      enable = true;
      virtualHosts = {
        "cxl.sh" = {
          addSSL = true;
          enableACME = true;

          root = "/srv/web/landing";
        };
      };
    };
  };
}
