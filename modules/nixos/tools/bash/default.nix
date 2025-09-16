{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.bash;
in {
  options.${namespace}.tools.bash = with types; {
    enable = mkEnableOption "tools";
  };

  config = mkIf cfg.enable {
    environment.localBinInPath = true;
    
    programs.bash = {
      shellAliases = {
        lsa = "ls -lAsh";
        p = "nix-shell -p";
      };

      interactiveShellInit = ''
        source "${./prompt.sh}"

        bind "set completion-ignore-case on"

        mkcd() {
          mkdir -p "$1"
          cd "$1"
        }
      '';
    };
  };
}
