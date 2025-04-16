{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.desktop.components.polybar;
  desktop = config.${namespace}.desktop;
in {
  options.${namespace}.desktop.components.polybar = with types; {
    enable = mkEnableOption "polybar";
  };

  config = mkIf cfg.enable {
    services.polybar = {
      enable = true;
      script = "";

      package = pkgs.polybar.override {
        i3Support = true;
        pulseSupport = true;
      };

      settings = let c = desktop.theme.colors; in {
        "bar/main" = {
          width = "100%";
          height = "24pt";
          radius = 0;

          background = "#${c.bg}";
          foreground = "#${c.fg}";

          font = [
            "Symbols Nerd Font:size=16;2"
            "monospace:size=11;2"
            "Sauce Code Pro Nerd Font:size=11;2"
            "Noto Sans CJK JP:size=11;1"
            "sans-serif:size=11;1"
          ];

          border = {
            top = "8px";
            left = "8px";
            right = "8px";

            color = "#00000000";
          };

          padding = {
            left = 2;
            right = 2;
          };

          cursor = {
            click = "pointer";
            scroll = "ns-resize";
          };

          enable-ipc = true;

          line.size = "3pt";

          separator = {
            text = "|";
            foreground = "#${c.bg3}";
          };

          module.margin = 1;
          modules = {
            left = "stat music";
            center = "i3";
            right = "wlan eth filesystem keyboard xkeyboard pulseaudio date";
          };
        };

        "module/keyboard" = {
          type = "custom/script";

          exec = "if [[ $(fcitx5-remote -n) == 'mozc' ]]; then printf 'jp'; else printf 'en'; fi";
          interval = 1;

          click.left = "${pkgs.fcitx5}/bin/fcitx5-remote -t";

          format = {
            prefix = {
              text = "󰌌 ";
              foreground = "#${c.accent}";
            };
          };
        };

        "module/music" = {
          type = "custom/script";

          exec = "playerctl --player=playerctld,cmus,firefox,%any -F metadata --format='{{title}} - {{artist}}'";
          tail = true;

          format = {
            prefix = {
              text = "󰎄 ";
              foreground = "#${c.accent}";
            };
          };
        };

        "module/stat" = {
          type = "custom/script";

          exec = "vmstat -n 2 | awk '{printf \"%.0f%% %.2f GiB\\\\n\", 100-$15, (31998756-($4+$5+$6))/1024/1024};fflush()'";
          tail = true;

          format = {
            prefix = {
              text = "󱕍 ";
              foreground = "#${c.accent}";
            };
          };
        };

        "module/i3" = {
          type = "internal/i3";

          strip-wsnumbers = true;
          index-sort = true;

          ws.icon = [
            "0:Main;󱄅" "1:Terminal;" "2:Browser;󰈹" "3:Chat;󰙯" "4:Gaming;󰓓"
            "5;󰎱" "6;󰎳" "7;󰎶"
            "8:Meow;󰄛" "9:Music;󰲸" "10:Misc;󰁴"
          ];

          label = {
            focused = {
              text = "%icon%";
              padding = 2;

              foreground = "#${c.fg0}";
              background = "#${c.bg1}";
              underline = "#${c.accent}";
            };

            visible = {
              text = "%icon%";
              padding = 2;

              underline = "#${c.fg4}";
            };

            unfocused = {
              text = "%icon%";
              padding = 2;
            };

            urgent = {
              text = "%icon%";
              padding = 2;

              foreground = "#${c.bg}";
              background = "#${c.accent}";
            };
          };
        };

        "module/xwindow" = {
          type = "internal/xwindow";
          label = "%title:0:64:...%";
        };


        "module/pulseaudio" = {
          type = "internal/pulseaudio";

          format.volume = "<ramp-volume> <label-volume>";
      
          label = {
            volume = "%percentage%%";
            muted = {
              text = "󰝟 %percentage%%";
              foreground = "#${c.bg3}";
            };
          };

          ramp.volume = {
            text = [ "󰕿" "󰖀" "󰕾" ];
            foreground = "#${c.accent}";
          };
        };

        "module/xkeyboard" = {
          type = "internal/xkeyboard";
          blacklist = [ "num lock" ];

          indicator.icon = [ "caps lock;;󰌎" ];

          format = {
            text = "<label-indicator>";
          };

          label = {
            indicator.on = "%icon%";
          };
        };

        "module/cpu" = {
          type = "internal/cpu";
          interval = 2;

          format.prefix = {
            text = "CPU ";
            foreground = "#${c.accent}";
          };

          label = "%percentage%%";
        };

        "module/memory" = {
          type = "internal/memory";
          interval = 2;

          format.prefix = {
            text = "MEM ";
            foreground = "#${c.accent}";
          };

          label = "%gb_used%";
        };

        "module/filesystem" = {
          type = "internal/fs";
          interval = 25;

          mount = [ "/nix" "/persist" ];

          label = {
            mounted = "%{F#${c.accent}}󰋊%{F-} %used%";
            unmounted = {
              text = "%mountpoint%";
              foreground = "#${c.bg3}";
            };
          };
        };

        "module/eth" = {
          type = "internal/network";
          interface.type = "wired";
          interval = 2;

          format.connected = "<label-connected>";
          label.connected = "%{F#${c.accent}}󰈀%{F-} 󰄼 %downspeed% 󰄿 %upspeed%";
        };

        "module/wlan" = {
          type = "internal/network";
          interface.type = "wireless";
          interval = 2;

          format.connected = "<ramp-signal> <label-connected>";
          label.connected = "󰄼 %downspeed% 󰄿 %upspeed%";

          ramp-signal = {
            text = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
            foreground = "#${c.accent}";
          };
        };

        "module/date" = {
          type = "internal/date";
          interval = 1;

          date = "%H:%M";
          date-alt = "%Y-%m-%d %H:%M:%S";

          format.prefix = {
            text = "󰃰 ";
            foreground = "#${c.accent}";
          };
        };
      };
    };
  };
}
