{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.desktop;
in {
  options.${namespace}.desktop = with types; {
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
    };

    theme = {
      name = mkOption {
        type = enum [ "gruvbox" ];
        default = "gruvbox";
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

  config = {
    cxl.desktop.theme.colors = import ./theme/${cfg.theme.name}.nix;
  };
}
