{ config, pkgs, lib, inputs, ... }:
with lib;

let cfg = config.roles.web.proxy; in {
  options.roles.web.proxy = {
    enable = mkEnableOption "nginx reverse proxy";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 ];

    services.nginx = {
      enable = true;
      virtualHosts = {
        "localhost".locations = {
          "/test" = {
            recommendedProxySettings = true;
            proxyPass = "http://192.168.0.2/";
          };
          "/stargazers" = {
            recommendedProxySettings = true;
            proxyPass = "http://192.168.0.3/";
          };
        };
      };
    };
  };
}
