{ pkgs, ... }:

{
  environment = {
    localBinInPath = true;

    #TODO: migrate to writeShellScriptBin
    interactiveShellInit = ''
      source "${./bash}/prompt.sh"

      alias lsa="ls -lAsh"
      alias c="codium ."
      alias p="nix-shell -p"

      mkcd() {
        mkdir -p "$1"
        cd "$1"
      }
    '';

    variables = {
      EDITOR = "${pkgs.vim}/bin/vim";
    };
  };
}
