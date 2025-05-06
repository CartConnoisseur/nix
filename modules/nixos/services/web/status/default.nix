{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.web.status;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.web.status = with types; {
    enable = mkEnableOption "status webserver";
  };

  config = mkIf cfg.enable {
    cxl.services.web.enable = true;

    environment.persistence.${impermanence.location} = {
      directories = [
        "/srv/web/status"
      ];
    };
    
    services.nginx = {
      enable = true;
      virtualHosts = {
        "status.cxl.sh" = {
          addSSL = true;
          enableACME = true;

          locations."/" = {
            recommendedProxySettings = true;
            proxyPass = "http://127.0.0.1:6969/";
          };
        };
      };
    };

    systemd.services."cxl.web.status" = {
      enable = true;
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.cxl.status}/bin/status 6969 /srv/web/status/auth";
      };
    };
  };
}
