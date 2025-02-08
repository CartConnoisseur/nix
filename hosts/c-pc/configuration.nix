{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix
    ./network.nix
    ../../core
    ../../roles
  ];

  programs.fuse.userAllowOther = true;

  users.users = {
    root.hashedPasswordFile = "/secrets/passwords/root";

    "c" = {
      isNormalUser = true;
      hashedPasswordFile = "/secrets/passwords/c";
      extraGroups = [ "wheel" ];
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "c" = import ./home.nix;
    };
  };

  services = {
    printing.enable = true;

    hardware.openrgb.enable = true;
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "toys" "nix-shell -p cmatrix asciiquarium pipes cowsay figlet neofetch")

    firefox
    wineWowPackages.stable
    winetricks

    ffmpeg
    jellyfin

    go
    jdk21

    lutris
    libGL
  ];
  
  system.stateVersion = "23.11";
}
