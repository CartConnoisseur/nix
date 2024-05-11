{ lib, ... }:

with lib;

{
  options.theme = {
    background = mkOption {
      type = types.str;
      example = "mem.png";
      description = ''
        Background image. Path starts in ~/Pictures/bg/
      '';
    };

    colors = let
      mkColorOption = name: {
        inherit name;
        value = mkOption {
          type = types.strMatching "[a-fA-F0-9]{6}";
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
}
