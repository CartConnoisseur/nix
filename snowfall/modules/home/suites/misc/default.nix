{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.misc;
in {
  options.${namespace}.suites.misc = with types; {
    enable = mkEnableOption "misc";
  };

  config = mkIf cfg.enable {
    cxl = {
      apps = {
        fastfetch.enable = true;
        pfetch.enable = true;
        cmatrix.enable = true;
        asciiquarium.enable = true;
        pipes.enable = true;
        cowsay.enable = true;
        figlet.enable = true;
      };
    };
  };
}
