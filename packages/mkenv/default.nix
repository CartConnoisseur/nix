{ pkgs, ... }:

pkgs.writeShellScriptBin "mkenv" ''
  if [[ -f flake.nix && -f .envrc ]]; then
    echo "why"
    exit
  fi

  if [[ -f flake.nix ]]; then
    echo "flake exists, skipping"
  else
    nix flake init
  fi

  if [[ -f .envrc ]]; then
    echo "env exists, skipping"
  else
    echo "use flake" >> .envrc
    direnv allow
  fi
''
