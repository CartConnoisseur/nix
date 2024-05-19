{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji

      minecraftia
    ];

    fontconfig = {
       defaultFonts = {
         monospace = [ "CaskaydiaMono Nerd Font" ];
         sansSerif = [ "DejaVu Sans" "Noto Sans CJK JP" "Noto Sans" ];
         serif = [ "DejaVu Serif" "Noto Serif CJK JP" "Noto Serif" ];
       };
    };
  };
}
