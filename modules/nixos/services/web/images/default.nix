{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.web.images;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.web.images = with types; {
    enable = mkEnableOption "image webserver";
  };

  config = mkIf cfg.enable {
    cxl.services.web.enable = true;

    environment.persistence.${impermanence.location} = {
      directories = [
        "/srv/web/images"
      ];
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];
    
    services.nginx = {
      enable = true;
      virtualHosts = {
        "i.cxl.sh" = {
          addSSL = true;
          enableACME = true;

          root = "/srv/web/images";
        };
      };
    };
  };
}
