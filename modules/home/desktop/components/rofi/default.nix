{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.desktop.components.rofi;
  desktop = config.${namespace}.desktop;
in {
  options.${namespace}.desktop.components.rofi = with types; {
    enable = mkEnableOption "rofi";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;

      font = "monospace 12";

      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
        c = desktop.theme.colors;
      in {
        "@import" = "default";

        "*" = {
          background = mkLiteral "#${c.bg}";
          foreground = mkLiteral "#${c.fg}";
          foreground-alt = mkLiteral "#${c.bg3}";

          alternate-normal-background = mkLiteral "var(background)";

          selected-normal-foreground = mkLiteral "var(background)";
          selected-normal-background = mkLiteral "#${c.accent}";

          border-color = mkLiteral "var(background)";
          separatorcolor = mkLiteral "#${c.bg3}";
        };

        inputbar = {
          children = map mkLiteral [ "entry" "num-filtered-rows" "textbox-num-sep" "num-rows" ];
        };

        element = {
          children = map mkLiteral [ "element-icon" "element-text" ];
        };

        entry.placeholder = "";

        scrollbar.handle-color = mkLiteral "var(foreground-alt)";
        num-rows.text-color = mkLiteral "var(foreground-alt)";
        num-filtered-rows.text-color = mkLiteral "var(foreground-alt)";
        textbox-num-sep.text-color = mkLiteral "var(foreground-alt)";

        message.border = mkLiteral "1px solid 0px 0px";
        listview.border = mkLiteral "1px solid 0px 0px";
        sidebar.border = mkLiteral "1px solid 0px 0px";
      };
    };
  };
}
