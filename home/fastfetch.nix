{ lib, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    package = (pkgs.fastfetch.overrideAttrs (finalAttrs: previousAttrs: {
      cmakeFlags = [(lib.cmakeBool "ENABLE_IMAGEMAGICK6" true)];
    }));

    settings = {
      logo = {
        type = "kitty-direct";
        source = "~/Pictures/nonon.png";

        width = 36;
        height = 32;

        padding = {
          left = 4;
          right = 4;
        };
      };

      display = {
        separator = "";
      };

      modules = [
        { type = "custom"; format = "                    ハードウェア                    "; }
        { type = "custom"; format = "┌──────────────────────────────────────────────────┐"; }

        { type = "cpu"; key = " CPU "; }
        { type = "gpu"; key = " GPU "; format = "{2} [{6}]"; }
        { type = "memory"; key = " MEM "; }
        "break"
        {
          type = "disk";
          folders = "/nix:/persist";
          key = " 󰋊 ";
        }

        { type = "custom"; format = "└──────────────────────────────────────────────────┘"; }
        "break"

        { type = "custom"; format = "                    ソフトウェア                    "; }
        { type = "custom"; format = "┌──────────────────────────────────────────────────┐"; }

        { type = "title"; key = " 󰁥 "; format = "{1}@{2}"; }
        "break"
        { type = "os"; key = "  "; }
        { type = "kernel"; key = " 󰌽 "; format = "{1} {2}"; }
        { type = "packages"; key = " 󰆧 "; }
        "break"
        { type = "terminal"; key = "  "; }
        { type = "shell"; key = " 󱆃 "; }
        { type = "font"; key = " 󰬈 "; }
        "break"
        { type = "wm"; key = "  "; }
        { type = "theme"; key = " 󰏘 "; }
        "break"
        { type = "media"; key = " 󰝚 "; }
        { type = "datetime"; key = " 󰃰 "; }

        { type = "custom"; format = "└──────────────────────────────────────────────────┘"; }
        "break"

        "colors"
      ];
    };
  };
}