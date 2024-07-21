{ config, pkgs, lib, inputs, ... }:
with lib;

let cfg = config.roles.web.proxy; in {
  options.roles.web.proxy = {
    enable = mkEnableOption "nginx reverse proxy";
    personal = mkOption {
      type = types.str;
      default = "localhost:8080";
      description = "personal site address";
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 ];

    services.nginx = {
      enable = true;
      virtualHosts = {
        "caroline.larimo.re" = {
          serverAliases = [ "cxl.sh" "localhost" ];

          locations = {
            "/" = {
              recommendedProxySettings = true;
              proxyPass = "http://${cfg.personal}/";
            };
            "/test" = {
              recommendedProxySettings = true;
              proxyPass = "http://web-test.containers/";
            };
          };
        };
      };
    };
  };
}
