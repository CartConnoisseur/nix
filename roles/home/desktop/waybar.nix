{ config, pkgs, ... }:

{
  programs.waybar = {
    settings = {
      main = {
        layer = "top";
        position = "top";
        height = 32;
        output = [ "DP-3" ];

        modules-left = [ "cpu" "memory" "mpris" ];
        modules-center = [ "sway/workspaces" ];
        modules-right = [ "network" "disk" "keyboard-state" "pulseaudio" "clock" ];

        # Left
        "cpu" = {
          interval = 5;
          format = "{usage}% {avg_frequency} GHz";
        };

        "memory" = {
          interval = 5;
          format = "{used} GiB";
          tooltip-format = "{used}/{total} GiB ({percentage}%)";
        };

        "mpris" = {
          format = "󰎄 {status_icon} {title} - {artist}";
          tooltip-format = "[{status}] {dynamic} ({player})";
          status-icons = {
            playing = "󰏤";
            paused = "󰐊";
            stopped = "󰐊";
          };
        };

        # Center
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;

          format = "{icon}";
          format-icons = {
            "0:Main"     = "󱄅";
            "1:Terminal" = "";
            "2:Browser"  = "󰈹";
            "3:Chat"     = "󰙯";
            "4:Gaming"   = "󰓓";

            "5" = "󰎱";
            "6" = "󰎳";
            "7" = "󰎶";

            "8:Meow"  = "󰄛";
            "9:Music" = "󰲸";
            "10:Misc" = "󰁴";
          };
        };

        # Right
        "network" = {
          interval = 10;
          format-ethernet = "󰈀 {ifname}";
          format-wifi = "{icon} {ifname}";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        };
      };
    };
  };
}