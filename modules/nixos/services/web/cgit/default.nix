{ options, config, lib, namespace, pkgs, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.web.cgit;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.web.cgit = with types; {
    enable = mkEnableOption "git.cxl.sh webserver";

    virtualHost = mkOption {
      type = str;
    };

    path = mkOption {
      type = path;
      default = "/srv/git";
    };
  };

  config = mkIf cfg.enable {
    cxl.services.web.enable = true;

    services.cgit = {
      "public" = {
        enable = true;
        scanPath = cfg.path;
        nginx.virtualHost = cfg.virtualHost;

        user = "git";
        group = "git";

        settings = {
          strict-export = "git-daemon-export-ok";

          enable-git-config = true;
          enable-index-owner = true;

          root-title = cfg.virtualHost;
          root-desc = "caroline's git mirror :3 (see about tab)";
          root-readme = "${pkgs.writeText "cgit-readme.txt" ''
            these repos are all mirrored from my github (CartConnoisseur) as effectively a backup.
            i may eventually move to another "heavy" host (with issues, prs, etc), but for now the canonical versions of these are over there.
            you are welcome to clone them over http(s) from here, though, if you wish.
          ''}";

          readme = ":README.md";
        };

        gitHttpBackend.checkExportOkFiles = true;
      };

      "private" = {
        enable = true;
        scanPath = cfg.path;
        nginx.virtualHost = cfg.virtualHost;
        nginx.location = "/private/";

        user = "git";
        group = "git";

        settings = {
          enable-git-config = false;
        };

        gitHttpBackend.enable = false;
      };
    };
    
    services.nginx = {
      enable = true;
      virtualHosts = {
        "${cfg.virtualHost}" = {
          addSSL = true;
          enableACME = true;
          locations."/private/" = {
            basicAuth = {
              c = "password";
            };
          };
        };
      };
    };
  };
}
