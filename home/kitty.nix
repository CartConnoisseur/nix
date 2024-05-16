{ config, ... }:

{
  programs.kitty = {
    enable = true;

    font = { name = "monospace"; size = 8.0; };

    settings = let c = config.theme.colors; in {
      foreground = "#${c.fg}";
      background = "#000000";

      color0  = "#${c.black}";
      color1  = "#${c.red}";
      color2  = "#${c.green}";
      color3  = "#${c.yellow}";
      color4  = "#${c.blue}";
      color5  = "#${c.magenta}";
      color6  = "#${c.cyan}";
      color7  = "#${c.white}";

      color8  = "#${c.brightBlack}";
      color9  = "#${c.brightRed}";
      color10 = "#${c.brightGreen}";
      color11 = "#${c.brightYellow}";
      color12 = "#${c.brightBlue}";
      color13 = "#${c.brightMagenta}";
      color14 = "#${c.brightCyan}";
      color15 = "#${c.brightWhite}";
    };

    shellIntegration = {
      mode = "no-cursor";
      enableBashIntegration = true;
    };

    extraConfig = ''
      background_opacity 0.8
      confirm_os_window_close 0
    '';
  };
}
