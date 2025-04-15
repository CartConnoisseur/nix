{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.minecraft.stargazers;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.minecraft.stargazers = with types; {
    enable = mkEnableOption "stargazers minecraft server";

    port = mkOption {
      type = types.port;
      default = 25565;
      description = "server port";
    };

    start = mkOption {
      type = types.bool;
      default = true;
      description = "autostart";
    };
  };

  config = mkIf cfg.enable {
    cxl.services.minecraft.enable = true;

    #TODO: enable tmux
    #cxl.tools.tmux.enable = true;

    environment.persistence.${impermanence.location} = {
      directories = [
        "/srv/minecraft/stargazers"
      ];
    };

    services.minecraft-servers.servers.stargazers = {
      enable = true;
      openFirewall = true;
      autoStart = cfg.start;

      package = pkgs.fabricServers.fabric-1_21;

      operators = {
        "grippysockjail" = "9448c89d-34eb-4e2c-a231-8112eb1a9e4a";
        "antonymph" = "6b1f7a3c-a1c3-491a-8514-12b6b90d9152";
      };

      serverProperties = {
        white-list = true;
        enforce-whitelist = true;

        gamemode = "survival";
        difficulty = "hard";
        level-seed = "4167799982467607063";
        spawn-protection = 0;

        max-players = 69;
        motd = "\\u00a7r                  \\u00a75\\u00a7lstrge gazrer\\u00a7r\\n join or i will rip your bones out and eat them";

        server-port = cfg.port;
        query-port = cfg.port;
      };

      symlinks.mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
        fabric = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/vMQdA5QJ/fabric-api-0.100.7%2B1.21.jar";
          sha256 = "sha256-grNmYgSekBaTztR1SLbqZCOC6+QNUDLe4hp105qfibA=";
        };
        lithium = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/my7uONjU/lithium-fabric-mc1.21-0.12.7.jar";
          sha256 = "sha256-Qku6c545jVgrdxDSNe3BULVQlMtgGuXebNqirRcmsh0=";
        };
        noChatReports = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/riMhCAII/NoChatReports-FABRIC-1.21-v2.8.0.jar";
          sha256 = "sha256-jskscOeK3ri2dt3mvWLPVmzddwPqBHJ8Ps+VfZ6l9os=";
        };
        appleskin = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/YxFxnyd4/appleskin-fabric-mc1.21-3.0.2.jar";
          sha256 = "sha256-8XaZREWzA5Mi2/LTs/a6ACvDKmHWYIy8JcOfQaq4yiE=";
        };
      });
    };
  };
}
