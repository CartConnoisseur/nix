{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.dev;
  impermanence = config.${namespace}.impermanence;
  desktop = config.${namespace}.suites.desktop;
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
      apps = {
        vscode.enable = desktop.enable;
        intellij.enable = desktop.enable;
      };

      tools = {
        cloc.enable = true;
        tmux.enable = true;
      };
    };
  };
}
