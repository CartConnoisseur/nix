{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.web.personal;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.web.personal = with types; {
    enable = mkEnableOption "personal site webserver";
  };

  config = mkIf cfg.enable {
    cxl.services.web.enable = true;

    networking.firewall.allowedTCPPorts = [ 80 443 ];
    
    services.nginx = {
      enable = true;
      virtualHosts = {
        "caroline.larimo.re" = {
          # serverAliases = [ "cxl.sh" ];

          addSSL = true;
          enableACME = true;

          locations."/" = {
            recommendedProxySettings = true;
            proxyPass = "http://127.0.0.1:8080/";
          };
        };
      };
    };

    systemd.services."cxl.web.personal" = {
      enable = true;
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        WorkingDirectory = "${pkgs.cxl.site}/share/site";
        ExecStart = "${pkgs.cxl.site}/bin/site";
      };
    };
  };
}
