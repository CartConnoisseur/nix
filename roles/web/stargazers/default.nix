{ config, pkgs, lib, inputs, ... }:
with lib;

let cfg = config.roles.web.stargazers; in {
  options.roles.web.stargazers = {
    enable = mkEnableOption "stargazers webserver";
  };

  config = mkIf cfg.enable {
    containers.web-stargazers = {
      autoStart = true;

      privateNetwork = true;
      hostAddress = "192.168.0.1";
      localAddress = "192.168.0.3";

      bindMounts = {
        "/srv/web/stargazers" = {
          hostPath = "/srv/web/stargazers";
          isReadOnly = true;
        };
      };

      config = { ... }: {
        system.stateVersion = "23.11";
        networking.firewall.allowedTCPPorts = [ 80 ];

        services.nginx = {
          enable = true;
          virtualHosts = {
            "192.168.0.3".root = "/srv/web/stargazers";
          };
        };
      };
    };
  };
}
