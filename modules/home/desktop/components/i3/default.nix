{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.desktop.components.i3;
  desktop = config.${namespace}.desktop;
in {
  options.${namespace}.desktop.components.i3 = with types; {
    enable = mkEnableOption "i3";
  };

  config = mkIf cfg.enable {
    #TODO: these probably shouldnt go here
    home.packages = with pkgs; [
      kdePackages.breeze
    ];

    home.file.".Xresources".text = ''
      Xcursor.size:   24
      Xcursor.theme:  breeze_cursors
    '';

    xsession.windowManager.i3 = {
      enable = true;
      config = let
        #NOTE: Alt (Mod1) and meta (Mod4) have been swapped by keyd.
        mod = "Mod4";
  
        ws0 = "0:Main";
        ws1 = "1:Terminal";
        ws2 = "2:Browser";
        ws3 = "3:Chat";
        ws4 = "4:Gaming";
        ws5 = "5";
        ws6 = "6";
        ws7 = "7";
        ws8 = "8:Meow";
        ws9 = "9:Music";
        ws10 = "10:Misc";
        ws11 = "11:Empty";
  
        output = {
          primary = "primary";
          left = "DVI-D-0";
          right = "DisplayPort-1 HDMI-A-0";
        };
      in {
        modifier = "${mod}";
  
        fonts = {
          names = [ "monospace" ];
          size = 8.0;
        };
  
        colors = let c = desktop.theme.colors; in {
          focused = {
            border = "#${c.fg2}";
            background = "#${c.fg2}";
            text = "#${c.bg}";
            indicator = "#${c.fg2}";
            childBorder = "#${c.fg2}";
          };
  
          focusedInactive = {
            border = "#${c.bg1}";
            background = "#${c.bg1}";
            text = "#${c.fg}";
            indicator = "#${c.bg1}";
            childBorder = "#${c.bg1}";
          };
  
          unfocused = {
            border = "#${c.bg}";
            background = "#${c.bg}";
            text = "#${c.fg}";
            indicator = "#${c.bg}";
            childBorder = "#${c.bg}";
          };
        };
  
        gaps.inner = 8;
  
        workspaceOutputAssign = [
          { workspace = "${ws0}"; output = output.primary; }
          { workspace = "${ws1}"; output = output.primary; }
  
          { workspace = "${ws2}"; output = output.left; }
          { workspace = "${ws3}"; output = output.left; }
  
          { workspace = "${ws4}"; output = output.primary; }
  
          { workspace = "${ws5}"; output = output.primary; }
          { workspace = "${ws6}"; output = output.primary; }
          { workspace = "${ws7}"; output = output.primary; }
  
          { workspace = "${ws8}"; output = output.primary; }
          { workspace = "${ws9}"; output = output.right; }
          { workspace = "${ws10}"; output = output.primary; }
  
          { workspace = "${ws11}"; output = output.primary; }
        ];
  
        assigns = {
          "${ws2}" = [ { class = "firefox"; } ];
          "${ws3}" = [ { class = "discord"; } ];
          "${ws4}" = [
            { class = "steam"; }
            { class = "prismlauncher"; }
          ];
  
          "${ws8}" = [ { class = "qbittorrent"; } ];
          "${ws9}" = [ { title = "cmus"; } ];
        };
  
        startup = [
          { command = "polybar-msg cmd quit; polybar"; always = true; notification = false; }
          { command = "systemctl --user restart picom"; always = true; notification = false; }
          { command = "${pkgs.feh}/bin/feh --bg-fill ${desktop.background}"; always = true; notification = false; }
        ] ++ optionals desktop.components.fcitx5.enable [
          { command = "fcitx5 -dr"; always = true; notification = false; }
        ];
  
        keybindings = {
          "${mod}+Shift+c" = "reload";
          "${mod}+Shift+r" = "restart";
          "${mod}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'\"";
  
          "${mod}+q" = "kill";
          "${mod}+d" = "exec \"rofi -modi drun,run -show drun\"";
          "${mod}+Return" = "exec ${pkgs.kitty}/bin/kitty";
  
          "${mod}+Num_Lock" = "exec --no-startup-id polybar-msg cmd toggle";
  
          # Screenshots
          #TODO: screen and full should be swapped, but currently screen is fucky :'(
          "Shift+Print" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot screen -c";
          "Print" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot full -c";
          "${mod}+Shift+s" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui -c";
          "Mod1+Shift+s" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui -c";
          "${mod}+Ctrl+Shift+s" = "exec --no-startup-id ${pkgs.flameshot}/bin/flameshot launcher -c";
  
          # Media keys
          "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +2%";
          "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -2%";
          "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
  
          "XF86AudioPlay" = "exec --no-startup-id \"playerctl --player=playerctld,cmus,firefox,%any play-pause\"";
          "XF86AudioPause" = "exec --no-startup-id \"playerctl --player=playerctld,cmus,firefox,%any play-pause\"";
          "XF86AudioStop" = "exec --no-startup-id \"playerctl --player=playerctld,cmus,firefox,%any stop\"";
          "XF86AudioNext" = "exec --no-startup-id \"playerctl --player=playerctld,cmus,firefox,%any next\"";
          "XF86AudioPrev" = "exec --no-startup-id \"playerctl --player=playerctld,cmus,firefox,%any previous\"";
  
          # Media controller widget
          "${mod}+m" = "exec --no-startup-id eww-toggle music --arg pos=center --arg gaps=false";
          "${mod}+Ctrl+m" = "exec --no-startup-id eww-toggle music --arg pos=right --arg gaps=true";
          "${mod}+Shift+m" = "exec --no-startup-id eww-toggle music --arg pos=center --arg gaps=true";
          "${mod}+Shift+Ctrl+m" = "exec --no-startup-id eww-toggle music --arg pos=right --arg gaps=false";
  
          # Workspaces
          "${mod}+grave" = "workspace number ${ws0}";
          "${mod}+1" = "workspace number ${ws1}";
          "${mod}+2" = "workspace number ${ws2}";
          "${mod}+3" = "workspace number ${ws3}";
          "${mod}+4" = "workspace number ${ws4}";
          "${mod}+5" = "workspace number ${ws5}";
          "${mod}+6" = "workspace number ${ws6}";
          "${mod}+7" = "workspace number ${ws7}";
          "${mod}+8" = "workspace number ${ws8}";
          "${mod}+9" = "workspace number ${ws9}";
          "${mod}+0" = "workspace number ${ws10}";
          "${mod}+equal" = "workspace number ${ws11}";
  
          # Move active workspace
          "${mod}+comma" = "move workspace to output ${output.left}";
          "${mod}+period" = "move workspace to output ${output.primary}";
          "${mod}+slash" = "move workspace to output ${output.right}";
  
          # Layout
          "${mod}+z" = "layout stacking";
          "${mod}+x" = "layout tabbed";
          "${mod}+c" = "layout toggle split";
  
          # Focus
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
  
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";
  
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";
  
          # Move focused container
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";
  
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";
  
          # Misc container binds
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+Ctrl+Shift+space" = "sticky toggle";
          "${mod}+f" = "fullscreen toggle";
  
          "${mod}+w" = "split h";
          "${mod}+e" = "split v";
  
          "${mod}+r" = "mode resize";
  
          # Move focused container to workspace
          "${mod}+Shift+grave" = "move container to workspace number ${ws0}";
          "${mod}+Shift+1" = "move container to workspace number ${ws1}";
          "${mod}+Shift+2" = "move container to workspace number ${ws2}";
          "${mod}+Shift+3" = "move container to workspace number ${ws3}";
          "${mod}+Shift+4" = "move container to workspace number ${ws4}";
          "${mod}+Shift+5" = "move container to workspace number ${ws5}";
          "${mod}+Shift+6" = "move container to workspace number ${ws6}";
          "${mod}+Shift+7" = "move container to workspace number ${ws7}";
          "${mod}+Shift+8" = "move container to workspace number ${ws8}";
          "${mod}+Shift+9" = "move container to workspace number ${ws9}";
          "${mod}+Shift+0" = "move container to workspace number ${ws10}";
        };
  
        modes = {
          resize = {
            "h" = "resize shrink width 10 px or 10 ppt";
            "j" = "resize grow height 10 px or 10 ppt";
            "k" = "resize shrink height 10 px or 10 ppt";
            "l" = "resize grow width 10 px or 10 ppt";
  
            "Left" = "resize shrink width 10 px or 10 ppt";
            "Down" = "resize grow height 10 px or 10 ppt";
            "Up" = "resize shrink height 10 px or 10 ppt";
            "Right" = "resize grow width 10 px or 10 ppt";
  
            "Return" = "mode default";
            "Escape" = "mode default";
            "${mod}+r" = "mode default";
          };
        };
  
        bars = [];
      };
  
      extraConfig = ''
        default_border normal 0
      '';
    };
  };
}
