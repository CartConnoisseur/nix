{ config, pkgs, lib, inputs, ... }:
with lib;

let 
  cfg = config.roles.web.personal;
  package = (pkgs.buildGoModule rec {
    pname = "site";
    version = "6612d84c63a7bbc2a5b70607f2ec32ea070c4659";

    src = pkgs.fetchFromGitHub {
      owner = "CartConnoisseur";
      repo = "site";
      rev = "${version}";
      hash = "sha256-n54+LdtMyjoLfaFqd7tcDQqBiYCdUW/Rs67Vc4QwEJ0=";
    };

    # kinda a hack, but whatever
    postBuild = ''
      mkdir -p $out/share/site
      cp -r $src/* $out/share/site/
    '';

    vendorHash = "sha256-2/4Wv7nsaT0wnUzkRgHKpSswigDj9nOvlmYXK29rvLU=";
  });
in {
  options.roles.web.personal = {
    enable = mkEnableOption "personal site";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    
    services.nginx = {
      enable = true;
      virtualHosts = {
        "caroline.larimo.re" = {
          serverAliases = [ "cxl.sh" ];

          addSSL = true;
          enableACME = true;

          locations."/" = {
            recommendedProxySettings = true;
            proxyPass = "http://localhost:8080/";
          };
        };
      };
    };

    systemd.services."web.personal" = {
      enable = true;
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        WorkingDirectory = "${package}/share/site";
        ExecStart = "${package}/bin/site";
      };
    };
  };
}
