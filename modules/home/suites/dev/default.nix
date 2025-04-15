{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.dev;
  impermanence = config.${namespace}.impermanence;
  desktop = config.${namespace}.desktop;
in {
  options.${namespace}.suites.dev = with types; {
    enable = mkEnableOption "dev";
  };

  config = mkIf cfg.enable {
    home.persistence.${impermanence.location} = {
      directories = [
        "code"
      ];
    };

    cxl = {
      apps = mkIf desktop.enable {
        vscode.enable = true;
        intellij.enable = true;
      };

      tools = {
        cloc.enable = true;
        tmux.enable = true;
      };
    };
  };
}
