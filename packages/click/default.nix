{ pkgs, ... }:

let
  xdotool = "${pkgs.xdotool}/bin/xdotool";
  xwininfo = "${pkgs.xorg.xwininfo}/bin/xwininfo";
  awk = "${pkgs.gawk}/bin/awk";
in pkgs.writeShellScriptBin "click" ''
  set -euo pipefail
  IFS=$'\n\t'

  delay="''${1:-1}"
  button="''${2:-1}"

  printf 'click target window: '
  id="$(${xwininfo} | ${awk} '/Window id:/{print $4}')"
  printf '%s\n' "$id"

  declare -i count=0
  while true; do
    ${xdotool} click --window "$id" "$button"

    printf '\rclick count: %d' "$((count += 1))"

    sleep "$delay"
  done
''
