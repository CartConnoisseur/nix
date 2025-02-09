{ config, lib, pkgs, inputs, ... }:

{
  environment.persistence."/persist/system" = {
    directories = [
      "/var/lib/acme"

      "/srv/web"
      "/srv/minecraft"
    ];
  };

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

  roles = {
    minecraft = {
      enable = true;

      servers = {
        stargazers = {
          enable = true;
          port = 25566;
        };
      };

      zenith = {
        enable = true;
        port = 25569;
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
}
