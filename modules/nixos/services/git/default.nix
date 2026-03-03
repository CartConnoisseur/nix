{ options, config, lib, namespace, pkgs, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.git;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.git = with types; {
    enable = mkEnableOption "git server";

    host = mkOption {
      type = str;
    };

    path = mkOption {
      type = path;
      default = "/srv/git";
    };

    adminPubkey = mkOption {
      type = str;
    };
  };

  config = mkIf cfg.enable {
    cxl.services.web.cgit = {
      enable = true;
      path = cfg.path + "/repositories";
      virtualHost = cfg.host;
    };

    environment.persistence.${impermanence.location} = {
      directories = [
        cfg.path
      ];
    };

    services.gitolite = {
      enable = true;

      user = "git";
      group = "git";
      description = "git";

      adminPubkey = cfg.adminPubkey;
      dataDir = cfg.path;

      extraGitoliteRc = ''
        $RC{GIT_CONFIG_KEYS} = 'cgit.* remote.origin.*';
      '';
    };

    systemd = {
      timers."cxl.git-mirror" = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          Unit = "cxl.git-mirror.service";
        };
      };

      services."cxl.git-mirror" = {
        #TODO: make this not shit
        script = ''
          API="https://api.github.com"
          API_USER="CartConnoisseur"
          API_HEADERS="-H 'Accept: application/vnd.github+json' -H 'X-GitHub-Api-Version: 2022-11-28' -H 'User-Agent: CartConnoisseur'"

          for dir in *; do
            if [[ -d "$dir" ]]; then
              if ! origin="$(${pkgs.git}/bin/git -C "$dir" remote get-url origin 2> /dev/null)"; then continue; fi
              if ! [[ "$origin" == *"github.com"* ]]; then continue; fi
              if ! [[ "$origin" == *"$API_USER"* ]]; then continue; fi
              repo="''${origin##*/}"

              if ! res="$(${pkgs.curl}/bin/curl -s -L $API_HEADERS "$API/repos/$API_USER/''${repo%.git}")"; then continue; fi
              desc="$(${pkgs.jq}/bin/jq -r '.description' <<<"$res")"
              printf '%s\n' "$desc" > "$dir/description"
              printf 'synced %s desc: %s\n' "$dir" "$desc"

              ${pkgs.git}/bin/git -C "$dir" fetch --prune origin
              printf 'synced %s commits\n' "$dir"
            fi
          done
        '';

        serviceConfig = {
          Type = "oneshot";
          User = "git";
          WorkingDirectory = cfg.path + "/repositories";
        };
      };
    };
  };
}
