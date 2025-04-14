{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.web.stargazers;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.web.stargazers = with types; {
    enable = mkEnableOption "stargazers webserver";
  };

  config = mkIf cfg.enable {
    cxl.services.web.enable = true;

    environment.persistence.${impermanence.location} = {
      directories = [
        "/srv/web/stargazers"
      ];
    };

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
