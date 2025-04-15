{ options, config, lib, namespace, inputs, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.minecraft;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.minecraft = with types; {
    enable = mkEnableOption "minecraft server support";
  };

  config = mkIf cfg.enable {
    nixpkgs = {
      overlays = [ inputs.nix-minecraft.overlay ];
      config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "minecraft-server"
      ];
    };

    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
    };
  };
}
