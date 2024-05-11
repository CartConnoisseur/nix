{ lib, ... }:

with lib;

{
  options.colors = 
    let
      mkColorOption = name: {
        inherit name;
        value = mkOption {
#          type = types.strMatching "[a-fA-F0-9]{6}";
          type = types.strMatching "[a-fA-F0-9]*";
          description = "Color ${name}.";
        };
      };
    in listToAttrs (map mkColorOption [
      "primary" "secondary"
      "foreground" "foregroundAlt"
      "background" "backgroundAlt"

      "accent"

      "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white"
      "brightBlack" "brightRed" "brightGreen" "brightYellow" "brightBlue" "brightMagenta" "brightCyan" "brightWhite"

      "bg" "bg0" "bg1" "bg2" "bg3" "bg4"
      "fg" "fg0" "fg1" "fg2" "fg3" "fg4"

      "orange" "brightOrange"
   ]);
}
