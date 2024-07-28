{ config, lib, pkgs, ... }:
with lib;

let cfg = config.home.roles.desktop; in {
  imports = [
    ./theme.nix

    ./i3.nix
    ./picom.nix
    ./polybar.nix
    ./rofi.nix
    ./kitty.nix

    ./gtk.nix
    ./fcitx5.nix

    ./discord.nix
    ./eww.nix
    ./mpv.nix
    ./flameshot.nix
    ./fastfetch.nix
    ./cmus.nix
  ];

  options.home.roles.desktop = {
    enable = mkEnableOption "desktop home role";

    discord = mkOption {
      type = types.bool;
      default = cfg.enable;
    };

    eww = mkOption {
      type = types.bool;
      default = cfg.enable;
    };

    mpv = mkOption {
      type = types.bool;
      default = cfg.enable;
    };

    screenshot = mkOption {
      type = types.bool;
      default = cfg.enable;
    };

    fetch = mkOption {
      type = types.bool;
      default = cfg.enable;
    };

    music = mkOption {
      type = types.bool;
      default = cfg.enable;
    };
  };

  config = mkIf cfg.enable {
    xsession.windowManager.i3.enable = true;

    gtk.enable = true;

    programs = {
      rofi.enable = true;
      kitty.enable = true;

      mpv.enable = cfg.mpv;
      fastfetch.enable = cfg.fetch;
    };

    services = {
      picom.enable = true;
      polybar.enable = true;

      flameshot.enable = cfg.screenshot;
    };

    home = {
      packages = with pkgs; [
        kdePackages.breeze
      ];

      file.".Xresources".text = ''
        Xcursor.size:   24
        Xcursor.theme:  breeze_cursors
      '';
    };
  };
}
