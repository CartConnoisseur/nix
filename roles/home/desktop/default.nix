{ config, lib, pkgs, ... }:
with lib;

let cfg = config.home.roles.desktop; in {
  imports = [
    ./theme.nix

    ./sway.nix
    ./waybar.nix
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
    wayland.windowManager.sway.enable = true;

    gtk.enable = true;

    programs = {
      waybar.enable = true;
      rofi.enable = true;
      kitty.enable = true;

      mpv.enable = cfg.mpv;
      fastfetch.enable = cfg.fetch;
    };

    services = {
      #picom.enable = true;
      #polybar.enable = true;

      flameshot.enable = cfg.screenshot;
    };

    home = {
      packages = with pkgs; [
        (writeShellScriptBin "switch-theme" ''
          #!/usr/bin/env bash

          cd /etc/nixos

          rm theme.nix
          ln -s ./themes/$1.nix theme.nix

          sudo nixos-rebuild switch --flake path:/etc/nixos

          i3-msg restart
        '')

        kdePackages.breeze
      ];

      file.".Xresources".text = ''
        Xcursor.size:   24
        Xcursor.theme:  breeze_cursors
      '';
    };
  };
}
