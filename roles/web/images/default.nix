{ config, lib, ... }:
with lib;

let 
  cfg = config.roles.web.images;
in {
  options.roles.web.images = {
    enable = mkEnableOption "images site";
  };

  config = mkIf cfg.enable {
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
