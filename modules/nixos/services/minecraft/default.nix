{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.minecraft;
in {
  options.${namespace}.services.minecraft = with types; {
    enable = mkEnableOption "minecraft server support";
  };

  config = mkIf cfg.enable {
    cxl.tools.tmux.enable = true;
    
    services.minecraft-servers = {
      enable = true;
      eula = true;
      openFirewall = true;
    };
  };
}
