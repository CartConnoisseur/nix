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

  xdg.configFile."eww/eww.css".text = ''
    @import "colors.css";

    window {
        color: @fg;
        background-color: @bg;
        border: 2px solid @bg1;
        border-bottom: none;
    }

    .main {
        margin: 8px;
    }

    .left {
        margin-top: 8px;
    }

    .song-title {
        font-size: 16px;
        font-weight: bold;
    }

    .song-album {
        color: @fg2;
    }

    .song-artist {
        color: @fg2;
    }

    .control {
        font-size: 24;
    }

    button {
        color: @fg;
        background: @bg;

        border: none;
        border-radius: 0;
        box-shadow: none;
        text-shadow: none;
    }

    button:hover {
        background: @bg1;
    }

    button:active {
        background: @bg2;
    }
  '';

  xdg.configFile."eww/eww.yuck".text = ''
    (defwindow music [pos]
        :monitor 0
        :geometry (geometry
            :x { pos == "right" ? "2px" : "0px" }
            :y "0px"
            :height {128 + 16}
            :anchor { pos == "right" ? "bottom right" : "bottom center" }
        )
        :stacking "fg"
        :windowtype "dock"
        :wm-ignore true

        (box :class "main"
            :orientation "h"
            :spacing 8
            :space-evenly false
            :height {128 + 16}

            (image
                :path { substring(song-cover, 7, 255) }
                :image-width 128
                :image-height 128
            )

            (box :class "left"
                :orientation "v"
                :spacing 0
                :space-evenly true
                :hexpand true

                (box :class "info"
                    :orientation "v"
                    :space-evenly false
                    :valign "center"

                    (label :class "song-title"
                        :text song-title
                        :halign "start"
                    )
                    (label :class "song-album"
                        :text song-album
                        :halign "start"
                    )
                    (label :class "song-artist"
                        :text song-artist
                        :halign "start"
                    )
                )

                (box :class "control"
                    :space-evenly false
                    :halign "center"
                    :valign "end"

                    (button
                        :onclick `playerctl previous`
                        "󰒮"
                    )
                    (button
                        :onclick `playerctl play-pause`
                        { song-status == "Playing" ? "󰏤" : "󰐊" }
                    )
                    (button
                        :onclick `playerctl next`
                        "󰒭"
                    )

                    ; Offset controls to center of screen
                    (box :width {128 + 8})
                )
            )
        )
    )

    (deflisten song-title
        `playerctl -F metadata title`
    )

    (deflisten song-album
        `playerctl -F metadata album`
    )

    (deflisten song-artist
        `playerctl -F metadata artist`
    )

    (deflisten song-cover
        `playerctl -F metadata mpris:artUrl`
    )

    (deflisten song-status
        `playerctl -F status`
    )
  '';
}
