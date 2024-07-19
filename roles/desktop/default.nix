{ config, pkgs, lib, ... }:
with lib;

let cfg = config.roles.desktop; in {
  imports = [
    ./input.nix
    ./xserver.nix
  ];

  options.roles.desktop = {
    enable = mkEnableOption "desktop";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pulseaudio
      playerctl
    ];

    security.rtkit.enable = true;

    i18n.inputMethod.enable = true;

    services = {
      displayManager.enable = true;

      xserver = {
        enable = true;
        displayManager.lightdm.enable = true;
        windowManager.i3.enable = true;
      };
      
      keyd.enable = true;

      pipewire = {
        enable = true;

        pulse.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        #jack.enable = true;
      };
    };

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
  };
}
