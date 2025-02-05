{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.fonts;
in {
  options.${namespace}.fonts = with types; {
    enable = mkEnableOption "fonts";
    nerdfonts = mkEnableOption "nerdfonts";
    extra = mkOption {
      type = listOf package;
      default = [];
      description = ''
        additional fonts to install
      '';
    };
  };

  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
      ] ++ (
        optionals cfg.nerdfonts (
          cfg.nerdfonts builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)
        )
      ) ++ cfg.extra;

      fontconfig.defaultFonts = {
        monospace = [ "CaskaydiaMono Nerd Font" ];
        sansSerif = [ "DejaVu Sans" "Noto Sans CJK JP" "Noto Sans" ];
        serif = [ "DejaVu Serif" "Noto Serif CJK JP" "Noto Serif" ];
      };
    };
  };
}
