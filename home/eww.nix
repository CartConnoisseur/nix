{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    eww

    (writeShellScriptBin "eww-toggle" ''
      if ${pkgs.eww}/bin/eww active-windows | grep $1; then
          ${pkgs.eww}/bin/eww close $1
      else
          ${pkgs.eww}/bin/eww open $@
      fi
    '')

    (writeShellScriptBin "get-album-art" ''
        OUTFILE=".mpris-art"

        while read -r line; do
            if [[ -n $line ]]; then
                rm -f ~/$OUTFILE

                cmus_path=$(${pkgs.cmus}/bin/cmus-remote -Q | grep file | cut -c 6-)
                if [[ -n $cmus_path ]]; then
                    if [[ -f $(dirname "$cmus_path")/cover.jpg ]]; then
                        cp "$(dirname "$cmus_path")/cover.jpg" ~/$OUTFILE
                    else
                        ${pkgs.ffmpeg}/bin/ffmpeg -y -v quiet -i "$cmus_path" -c:v copy -f mjpeg ~/$OUTFILE
                    fi
                else
                    mpris=$(${pkgs.playerctl}/bin/playerctl --player=cmus,firefox,%any metadata mpris:artUrl)

                    if [[ $mpris == data:image* ]]; then
                        echo $mpris | sed s/.*,//g | base64 --decode > ~/$OUTFILE
                    elif [[ -n $mpris ]]; then
                        curl -s -o ~/$OUTFILE $mpris
                    fi
                fi

                if [[ -f ~/$OUTFILE ]]; then
                    :
                else
                    cp ${../assets/album_art_placeholder.png} ~/$OUTFILE
                fi

                echo ~/$OUTFILE
            fi
        done
    '')
  ];

  xdg.configFile."eww/eww.yuck".source = eww/eww.yuck;
  xdg.configFile."eww/eww.css".source = eww/eww.css;

  xdg.configFile."eww/windows".source = eww/windows;

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
