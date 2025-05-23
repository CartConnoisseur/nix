{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.cmus;
  impermanence = config.${namespace}.impermanence;
in {
  options.${namespace}.apps.cmus = with types; {
    enable = mkEnableOption "cmus";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cmus
    ];

    home.persistence.${impermanence.location} = {
      directories = [
        ".config/cmus"
      ];
    };

    xdg.desktopEntries.cmus = {
      name = "cmus";
      genericName = "Music Player";
      exec = "${pkgs.kitty}/bin/kitty ${pkgs.cmus}/bin/cmus";
      categories = [ "Music" "Player" "Audio" "ConsoleOnly" ];
    };

    xdg.configFile."cmus/rc".text = ''
      set auto_expand_albums_follow=false
      set pause_on_output_change=true
      set repeat=true
      set shuffle=tracks

      fset unheard=play_count=0
      factivate

      set color_cmdline_attr=default
      set color_cmdline_bg=default
      set color_cmdline_fg=default
      set color_cur_sel_attr=default
      set color_error=231
      set color_info=lightyellow
      set color_separator=black
      set color_statusline_attr=default
      set color_statusline_bg=237
      set color_statusline_fg=248
      set color_titleline_attr=bold
      set color_titleline_bg=239
      set color_titleline_fg=default
      set color_trackwin_album_attr=bold
      set color_trackwin_album_bg=black
      set color_trackwin_album_fg=default
      set color_win_attr=default
      set color_win_bg=default
      set color_win_cur=231
      set color_win_cur_attr=default
      set color_win_cur_sel_attr=bold
      set color_win_cur_sel_bg=231
      set color_win_cur_sel_fg=black
      set color_win_dir=lightblue
      set color_win_fg=default
      set color_win_inactive_cur_sel_attr=bold
      set color_win_inactive_cur_sel_bg=237
      set color_win_inactive_cur_sel_fg=231
      set color_win_inactive_sel_attr=bold
      set color_win_inactive_sel_bg=237
      set color_win_inactive_sel_fg=default
      set color_win_sel_attr=bold
      set color_win_sel_bg=250
      set color_win_sel_fg=black
      set color_win_title_attr=bold
      set color_win_title_bg=250
      set color_win_title_fg=black
    '';
  };
}
