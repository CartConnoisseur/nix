{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.neovim;
  theme = config.${namespace}.desktop.theme;
in {
  options.${namespace}.tools.neovim = with types; {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      colorschemes."${theme.vim}".enable = true;

      opts = {
        number = true;
        relativenumber = true;
      };

      extraConfigVim = ''
        highlight Normal guibg=NONE
      '';

      plugins.lsp = {
        enable = true;

        servers = {
          zls.enable = true;
          asm_lsp.enable = true;
        };
      };

      plugins.nix.enable = true;
      plugins.trouble.enable = true;
    };
  };
}
