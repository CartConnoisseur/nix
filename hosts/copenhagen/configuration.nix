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

      "/srv/web"
      "/srv/minecraft"
    ];

    files = [
      "/etc/machine-id"
    ];
  };

  programs.fuse.userAllowOther = true;

  networking = {
    hostName = "copenhagen";
    hostId = "a50062ff";

    useDHCP = true;
  };

  time.timeZone = "America/Los_Angeles";

  users.users = {
    root.hashedPasswordFile = "/secrets/passwords/root";

    "c" = {
      isNormalUser = true;
      hashedPasswordFile = "/secrets/passwords/c";
      extraGroups = [ "wheel" "minecraft" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIDO8JxqS7B2n3YlNtlVMZGARi+GG/z7wLiiyl52qSZc caroline@larimo.re" # c-pc
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGftQ5W8QMIVhgDijreliiMgIqwQvxwTkpMftJdQWu+ caroline@larimo.re" # phoenix
      ];
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "c" = import ./home/c.nix;
    };
  };

  roles = {
    minecraft = {
      enable = true;
      servers = {
        stargazers = {
          enable = true;
          port = 25566;
        };
      };
    };
    web = {
      images.enable = true;
      stargazers.enable = true;
      personal.enable = true;
    };
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    pcscd.enable = true;
    openssh = {
      enable = true;
      ports = [ 42069 ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    ffmpeg
  ];

  system.stateVersion = "23.11";
}
