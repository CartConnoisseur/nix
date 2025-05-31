{ pkgs, ... }:

pkgs.writeShellScriptBin "mkenv" ''
  if [[ -f flake.nix && -f .envrc ]]; then
    echo "why"
    exit
  fi

  if [[ -f flake.nix ]]; then
    echo "flake exists, skipping"
  else
    cat <<EOF > flake.nix
{
  description = "very cool flake :3";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [

      ];
    };
  };
}
EOF
  fi

  if [[ -f .envrc ]]; then
    echo "env exists, skipping"
  else
    echo "use flake" >> .envrc
    direnv allow
  fi
''
