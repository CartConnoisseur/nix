{ options, config, lib, namespace, pkgs, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.web.cgit;
  impermanence = config.${namespace}.system.impermanence;
  package = (pkgs.cgit.overrideAttrs (previousAttrs: {
    postInstall = (previousAttrs.postInstall or "") + ''
      rm $out/cgit/favicon.ico # automatically fetched by browsers
      # install -m 0644 $\{./favicon.ico} $out/cgit/favicon.ico
      # install -m 0644 $\{./icon.png} $out/cgit/cgit.png
    '';
  }));
in {
  options.${namespace}.services.web.cgit = with types; {
    enable = mkEnableOption "git.cxl.sh webserver";

    virtualHost = mkOption {
      type = str;
    };

    ssl = mkOption {
      type = bool;
      default = true;
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
        package = package;

        scanPath = cfg.path;
        nginx.virtualHost = cfg.virtualHost;

        user = "git";
        group = "git";

        settings = {
          strict-export = "git-daemon-export-ok";

          enable-git-config = true;
          enable-index-owner = true;

          favicon = "";
          logo = "";

          root-title = cfg.virtualHost;
          root-desc = "caroline's git mirror :3 (see about tab)";
          root-readme = "${pkgs.writeText "cgit-readme.txt" ''
            these repos are all mirrored from my github (CartConnoisseur) as effectively a backup.
            i may eventually move to another "heavy" host (with issues, prs, etc), but for now the canonical versions of these are over there.
            you are welcome to clone them over http(s) from here, though, if you wish.
          ''}";

          source-filter = "${package}/lib/cgit/filters/syntax-highlighting.py";
          about-filter = "${package}/lib/cgit/filters/about-formatting.sh";
          readme = ":README.md";
        };

        gitHttpBackend.checkExportOkFiles = true;
      };

      "private" = {
        enable = true;
        scanPath = cfg.path;
        nginx.virtualHost = "private.${cfg.virtualHost}";

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
          addSSL = cfg.ssl;
          enableACME = cfg.ssl;
        };
        "private.${cfg.virtualHost}" = {
          addSSL = cfg.ssl;
          enableACME = cfg.ssl;

          extraConfig = ''
            ssl_client_certificate ${./ca.crt};
            ssl_verify_client on;
          '';
        };
      };
    };
  };
}
