# based on https://github.com/matejc/helper_scripts/blob/master/nixes/satisfactory.nix
#TODO: separate servers into modules
{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.satisfactory;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.satisfactory = {
    enable = lib.mkEnableOption "Enable Satisfactory Dedicated Server";

    port = mkOption {
      type = types.port;
      default = 7777;
      description = "server port";
    };

    dir = lib.mkOption {
      type = lib.types.path;
      default = "/srv/satisfactory"; #TODO: create subdirs for invidividual servers
      description = "server dir";
    };

    channel = lib.mkOption {
      type = lib.types.enum [ "public" "experimental" ];
      default = "public";
      description = "release channel";
    };

    start = mkOption {
      type = types.bool;
      default = true;
      description = "autostart";
    };

    extraSteamCmdArgs = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };
  
  config = lib.mkIf cfg.enable {
    environment.persistence.${impermanence.location} = {
      directories = [
        cfg.dir
      ];
    };

    users.users.satisfactory = {
      group = "satisfactory";
      home = cfg.dir;
      createHome = true;
      isSystemUser = true;
    };
    users.groups.satisfactory = {};

    #TODO: why tf does steam work but this doesnt??
    # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    #   "steamcmd"
    #   "steam-unwrapped"
    # ];

    networking = {
      firewall = {
        allowedTCPPorts = [ cfg.port 8888 ];
        allowedUDPPorts = [ cfg.port ];
      };
    };

    systemd.services.satisfactory = {
      wantedBy = mkIf cfg.start [ "multi-user.target" ];

      preStart = ''
        ${pkgs.steamcmd}/bin/steamcmd \
          +force_install_dir ${cfg.dir}/SatisfactoryDedicatedServer \
          +login anonymous \
          +app_update 1690800 \
          -beta ${cfg.channel} \
          ${cfg.extraSteamCmdArgs} \
          validate \
          +quit

        ${pkgs.patchelf}/bin/patchelf --set-interpreter ${pkgs.glibc}/lib/ld-linux-x86-64.so.2 ${cfg.dir}/SatisfactoryDedicatedServer/Engine/Binaries/Linux/FactoryServer-Linux-Shipping
        ln -sfv ${cfg.dir}/.steam/steam/linux64 ${cfg.dir}/.steam/sdk64

        mkdir -p ${cfg.dir}/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer
      '';
        # ${pkgs.crudini}/bin/crudini --set ${cfg.dir}/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer/Game.ini '/Script/Engine.GameSession' MaxPlayers ${toString cfg.maxPlayers}
        # ${pkgs.crudini}/bin/crudini --set ${cfg.dir}/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer/ServerSettings.ini '/Script/FactoryGame.FGServerSubsystem' mAutoPause ${if cfg.autoPause then "True" else "False"}
        # ${pkgs.crudini}/bin/crudini --set ${cfg.dir}/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer/ServerSettings.ini '/Script/FactoryGame.FGServerSubsystem' mAutoSaveOnDisconnect ${if cfg.autoSaveOnDisconnect then "True" else "False"}

      script = ''
        exec ${cfg.dir}/SatisfactoryDedicatedServer/FactoryServer.sh -Port ${toString cfg.port}
      '';

      serviceConfig = {
        Restart = "always";
        User = "satisfactory";
        Group = "satisfactory";
        WorkingDirectory = cfg.dir;
      };

      environment = {
        LD_LIBRARY_PATH="SatisfactoryDedicatedServer/linux64:SatisfactoryDedicatedServer/Engine/Binaries/Linux:SatisfactoryDedicatedServer/Engine/Binaries/ThirdParty/PhysX3/Linux/x86_64-unknown-linux-gnu";
      };
    };
  };
}
