{ config, lib, inputs, ... }:
with lib;

let cfg = config.roles.minecraft; in {
  imports = [
    ./servers
    ./zenith
  ];

  options.roles.minecraft = {
    enable = mkEnableOption "minecraft server role";
  };

  config = mkIf cfg.enable {
    nixpkgs = {
      overlays = [ inputs.nix-minecraft.overlay ];
      config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "minecraft-server"
      ];
    };

    programs.tmux.enable = true;

    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
    };
  };
}
