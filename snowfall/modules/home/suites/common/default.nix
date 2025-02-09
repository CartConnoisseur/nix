{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.common;
in {
  options.${namespace}.suites.common = with types; {
    enable = mkEnableOption "common";
  };

  config = mkIf cfg.enable {
    cxl = {
      tools = {
        bash.enable = true;
        vim.enable = true;
        git.enable = true;
        ssh.enable = true;
        gpg.enable = true;
        btop.enable = true;
      };
    };
  };
}
