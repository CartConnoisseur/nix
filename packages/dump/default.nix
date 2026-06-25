{ pkgs, ... }:

pkgs.writeShellScriptBin "dump" ''
  set -e
  
  filename="$(which $1)"
  if [[ "$(head -c 2 "$filename")" = "#!" ]]; then
    cat "$filename"
  else
    ${pkgs.xxd}/bin/xxd "$filename"
  fi
''
