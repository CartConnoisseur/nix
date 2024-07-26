{ lib, pkgs, ... }:

{
  programs.fastfetch = {
    package = (pkgs.fastfetch.overrideAttrs (finalAttrs: previousAttrs: {
      cmakeFlags = [(lib.cmakeBool "ENABLE_IMAGEMAGICK6" true)];
    }));

    settings = {
      logo = {
        type = "kitty-direct";
        source = "$(ls ${../../../assets/fastfetch}/*.png | shuf -n 1)";

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
#        { type = "font"; key = " 󰬈 "; }
        { type = "font"; key = " 󰬈 "; format = "Caskaydia Mono (8pt)"; }
        "break"
        { type = "wm"; key = "  "; }
#        { type = "theme"; key = " 󰏘 "; }
        { type = "theme"; key = " 󰏘 "; format = "gruvbox"; }
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
