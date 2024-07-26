{ config, lib, ... }:
with lib;

let cfg = config.roles.web.stargazers; in {
  options.roles.web.stargazers = {
    enable = mkEnableOption "stargazers webserver";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    
    services.nginx = {
      enable = true;
      virtualHosts = {
        "stargazers.xn--6frz82g" = {
          addSSL = true;
          enableACME = true;

          root = "/srv/web/stargazers";
        };
      };
    };
  };
}
