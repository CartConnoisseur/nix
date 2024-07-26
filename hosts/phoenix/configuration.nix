{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware.nix
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
    ];

    files = [
      "/etc/machine-id"
    ];
  };

  programs.fuse.userAllowOther = true;

  networking = {
    hostName = "phoenix";
    hostId = "d62900ff";

    networkmanager.enable = true;
  };

  time.timeZone = "America/Los_Angeles";

  users.users = {
    root.hashedPasswordFile = "/secrets/passwords/root";

    "c" = {
      isNormalUser = true;
      hashedPasswordFile = "/secrets/passwords/c";
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIDO8JxqS7B2n3YlNtlVMZGARi+GG/z7wLiiyl52qSZc caroline@larimo.re" ];
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "c" = import ./home.nix;
    };
  };

  roles = {
    desktop.enable = true;
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    dconf.enable = true;
  };

  services = {
    pcscd.enable = true;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    ffmpeg
  ];

  system.stateVersion = "24.05";
}
