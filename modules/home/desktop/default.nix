{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.desktop;
  themeType = with types; submodule {
    options = {
      name = mkOption {
        type = str;
      };

      gtk = {
        package = mkOption {
          type = types.nullOr types.package;
          default = null;
          example = literalExpression "pkgs.gnome.gnome-themes-extra";
          description = ''
            Package providing the theme. This package will be installed
            to your profile. If `null` then the theme
            is assumed to already be available in your profile.

            For the theme to apply to GTK 4, this option is mandatory.
          '';
        };

        name = mkOption {
          type = types.str;
          example = "Adwaita";
          description = "The name of the theme within the package.";
        };
      };

      colors = let
        mkColorOption = name: {
          inherit name;
          value = mkOption {
            type = strMatching "[a-fA-F0-9]{6}";
            default = "ff00ff";
            example = "23ce94";
            description = ''
              Hex value for color "${name}".
            '';
          };
        };
      in listToAttrs (map mkColorOption [
        "accent"

        "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white"
        "brightBlack" "brightRed" "brightGreen" "brightYellow" "brightBlue" "brightMagenta" "brightCyan" "brightWhite"

        "bg" "bg0" "bg1" "bg2" "bg3" "bg4"
        "fg" "fg0" "fg1" "fg2" "fg3" "fg4"

        "orange" "brightOrange"
      ]);
    };
  };
in {
  options.${namespace}.desktop = with types; {
    enable = mkEnableOption "desktop";

    background = mkOption {
      type = enum [
        "lycoris.png"
        "matama.png"
        "mem.png"
        "nonon.png"
        "ryo.png"
        "shinobu.png"
        "skull.png"
      ];
      apply = value: ./bg/${value};
    };

    themes = mkOption {
      type = attrsOf themeType;
    };

    theme = mkOption {
      type = themeType;
    };
  };
}
