{ config, pkgs, lib, inputs, ... }:
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
  ];

  options.home.roles.desktop = {
    enable = mkEnableOption "desktop home role";

    discord = mkOption {
      type = types.bool;
      default = true;
    };
    eww = mkOption {
      type = types.bool;
      default = true;
    };
    mpv = mkOption {
      type = types.bool;
      default = true;
    };
    screenshot = mkOption {
      type = types.bool;
      default = true;
    };
    fetch = mkOption {
      type = types.bool;
      default = true;
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
