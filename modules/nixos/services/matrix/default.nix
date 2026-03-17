{ options, config, lib, namespace, pkgs, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.matrix;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.matrix = with types; {
    enable = mkEnableOption "matrix server (continuwuity)";

    host = mkOption {
      type = str;
    };
  };

  config = mkIf cfg.enable {
    cxl.services.web.enable = true;

    environment.persistence.${impermanence.location} = {
      directories = [
        "/var/lib/private/continuwuity"
      ];
    };

    services.matrix-continuwuity = {
      enable = true;
      settings = {
        global = {
          server_name = cfg.host;
        };
      };
    };

    networking = {
      firewall = {
        allowedTCPPorts = [ 8448 ];
      };
    };

    services.nginx = {
      enable = true;
      virtualHosts = {
        "${cfg.host}" = {
          addSSL = true;

          extraConfig = ''
            listen 8448 ssl;
            listen [::]:8448 ssl;
          '';

          locations = {
            "/_matrix/" = {
              recommendedProxySettings = true;
              proxyPass = "http://127.0.0.1:6167";
            };
            "/.well-known/matrix/client" = {
              extraConfig = ''
                default_type application/json;
                add_header Access-Control-Allow-Origin *;
                return 200 '{"m.homeserver": {"base_url": "https://${cfg.host}:8448"}}';
              '';
            };
            "/.well-known/matrix/server" = {
              extraConfig = ''
                default_type application/json;
                return 200 '{"m.server": "${cfg.host}:8448"}';
              '';
            };
          };
        };
      };
    };
  };
}
