{ config, lib, pkgs, inputs, ... }:

{
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
}
