{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.dev;
  desktop = config.${namespace}.suites.desktop;
in {
  options.${namespace}.suites.dev = with types; {
    enable = mkEnableOption "dev";
  };

  config = mkIf cfg.enable {
    cxl = {
      apps = {
        vscode.enable = desktop.enable;
      };
    };
  };
}
