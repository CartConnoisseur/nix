{ config, lib, ... }:

{
  xdg.configFile."eww/colors.css".text = let c = config.theme.colors; in ''
    @define-color accent #${c.accent};

    @define-color black   #${c.black};
    @define-color red     #${c.red};
    @define-color green   #${c.green};
    @define-color yellow  #${c.yellow};
    @define-color blue    #${c.blue};
    @define-color magenta #${c.magenta};
    @define-color cyan    #${c.cyan};
    @define-color white   #${c.white};

    @define-color brightBlack   #${c.brightBlack};
    @define-color brightRed     #${c.brightRed};
    @define-color brightGreen   #${c.brightGreen};
    @define-color brightYellow  #${c.brightYellow};
    @define-color brightBlue    #${c.brightBlue};
    @define-color brightMagenta #${c.brightMagenta};
    @define-color brightCyan    #${c.brightCyan};
    @define-color brightWhite   #${c.brightWhite};

    @define-color bg  #${c.bg};
    @define-color bg0 #${c.bg0};
    @define-color bg1 #${c.bg1};
    @define-color bg2 #${c.bg2};
    @define-color bg3 #${c.bg3};
    @define-color bg4 #${c.bg4};

    @define-color fg  #${c.fg};
    @define-color fg0 #${c.fg0};
    @define-color fg1 #${c.fg1};
    @define-color fg2 #${c.fg2};
    @define-color fg3 #${c.fg3};
    @define-color fg4 #${c.fg4};

    @define-color orange #${c.orange};
    @define-color brightOrange #${c.brightOrange};
  '';
}
