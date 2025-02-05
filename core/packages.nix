{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "rb" "sudo nixos-rebuild switch --flake /etc/nixos")
    (writeShellScriptBin "rbf" "sudo nixos-rebuild switch --flake path:/etc/nixos")
    
    moreutils
    wget
    killall
    jq
  ];
}
