{ pkgs, ... }:

let
  python = "${pkgs.python3}/bin/python";
in pkgs.writeShellScriptBin "serve" ''
  exec ${python} -m http.server "$@"
''
