{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix
    ./network.nix
    ../../core
    ../../roles
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.persistence."/persist/system" = {
    hideMounts = true;

    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      #"/var/lib/bluetooth"
    ];
    
    files = [
      "/etc/machine-id"
    ];
  };

  programs.fuse.userAllowOther = true;

  time.timeZone = "America/Los_Angeles";

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

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];

  programs = {
    steam.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    dconf.enable = true;
  };

  services = {
    pcscd.enable = true;
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
