{ pkgs, ... }:

pkgs.writeShellScriptBin "fork" ''
  SHLVL=$((SHLVL-1)) exec kitty --directory=. --detach "$@" > /dev/null
''
