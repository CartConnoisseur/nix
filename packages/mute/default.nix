{ lib, pkgs, ... }:

let
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  jq = "${pkgs.jq}/bin/jq";
in pkgs.writeShellScriptBin "mute" ''
  set -euo pipefail
  IFS=$'\n\t'

  target="''${1:-0}"
  inputs="$(${pactl} -f json list sink-inputs)"

  if [[ "''${1:-}" != "" ]]; then
      index="$(${jq} '.['$target'].index' <<< "$inputs")"
      muted="$(${jq} '.['$target'].mute' <<< "$inputs")"
      if [[ "$muted" = "true" ]]; then
          ${pactl} set-sink-input-mute "$index" false
      else
          ${pactl} set-sink-input-mute "$index" true
      fi

      inputs="$(${pactl} -f json list sink-inputs)"
  fi

  count="$(${jq} 'length' <<< "$inputs")"
  for ((i = 0; i < $count; i++)); do
      index="$(${jq} '.['$i'].index' <<< "$inputs")"
      muted="$(${jq} '.['$i'].mute' <<< "$inputs")"
      name="$(${jq} '.['$i'].properties."application.name"' <<< "$inputs")"
      media="$(${jq} '.['$i'].properties."media.name"' <<< "$inputs")"

      state=" "
      if [[ "$muted" = "true" ]]; then
          state="*"
      fi

      printf '  [%d] %s %d\t%s\t(%s)\n' "$i" "$state" "$index" "$name" "$media"
  done
''
