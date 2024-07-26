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
    "steam-original"
    "steam-run"
  ];

  roles = {
    desktop = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      setupCommands = ''
        if ${pkgs.xorg.xrandr}/bin/xrandr --query | grep 2560x1080; then
          ${pkgs.xorg.xrandr}/bin/xrandr --output DVI-D-0 --mode 1920x1080  --rate 60  --pos 0x0
          ${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-2 --mode 2560x1080  --rate 60  --pos 1920x0 --primary
          ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-A-0 --mode 1920x1080  --rate 75  --pos 4480x0
        elif ${pkgs.xorg.xrandr}/bin/xrandr --query | grep 2560x1440; then
          ${pkgs.xorg.xrandr}/bin/xrandr --output DVI-D-0 --mode 1920x1080 --rate 60 --pos 0x360
          ${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-2 --mode 2560x1440 --rate 165 --pos 1920x0 --primary
          ${pkgs.xorg.xrandr}/bin/xrandr --output DisplayPort-1 --mode 1920x1200 --rate 60 --pos 4480x0
        fi
      '';
    };
  };

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
