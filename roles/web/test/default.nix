{ config, pkgs, lib, inputs, ... }:
with lib;

let cfg = config.roles.web.test; in {
  options.roles.web.test = {
    enable = mkEnableOption "test webserver";
  };

  config = mkIf cfg.enable {
    containers.web-test = {
      autoStart = true;

      privateNetwork = true;
      hostAddress = "192.168.0.1";
      localAddress = "192.168.0.2";

      bindMounts = {
        "/srv/web/test" = {
          hostPath = "/srv/web/test";
          isReadOnly = true;
        };
      };

      config = { ... }: {
        system.stateVersion = "23.11";
        networking.firewall.allowedTCPPorts = [ 80 ];

        services.nginx = {
          enable = true;
          virtualHosts = {
            "web-test".root = "/srv/web/test";
          };
        };
      };
    };
  };
}
