{ options, config, lib, pkgs, namespace, ... }:

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
    
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "mc-attach" ''
        file="/run/minecraft/$1.sock"

        if [[ -r "$file" && -w "$file" ]]; then
          tmux -S "$file" attach
        else
          sudo -u minecraft tmux -S "$file" attach
        fi
      '')
      
      (writeShellScriptBin "mc-shell" ''
        dir="/srv/minecraft"

        if [[ -v "$1" ]]; then
          dir="$1"
        fi

        cd "$dir"
        sudo -u minecraft "$SHELL"
      '')
    ];
  };
}
