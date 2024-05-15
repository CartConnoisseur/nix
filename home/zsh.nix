{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
      lsa = "ls -lAsh";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "systemd" ];
      #theme = "powerlevel10k";
    };
  };
}
