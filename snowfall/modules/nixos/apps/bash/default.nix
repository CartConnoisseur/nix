{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.bash;
in {
  options.${namespace}.apps.bash = with types; {
    enable = mkEnableOption "bash";
  };

  config = mkIf cfg.enable {
    #TODO: add c="codium ." alias
    programs.bash = {
      shellAliases = {
        lsa = "ls -lAsh";
        p = "nix-shell -p";
      };

      interactiveShellInit = ''
        source "${./prompt.sh}"

        mkcd() {
          mkdir -p "$1"
          cd "$1"
        }
      '';
    };
  };
}
