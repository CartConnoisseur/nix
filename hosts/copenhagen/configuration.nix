{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../core
    ../../roles
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "copenhagen";
  time.timeZone = "America/Los_Angeles";

  users.users = {
    root.password = "password";

    "c" = {
      isNormalUser = true;
      password = "password";
      extraGroups = [ "wheel" "minecraft" ];
    };
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "rb" "sudo nixos-rebuild switch --flake /etc/nixos#copenhagen")
    (writeShellScriptBin "rbf" "sudo nixos-rebuild switch --flake path:/etc/nixos#copenhagen")

    ffmpeg
  ];

  roles = {
    minecraft = {
      enable = true;
      servers = {
        test = {
          enable = true;
          port = 25566;
        };
      };
    };
    web = {
      proxy.enable = true;
      stargazers.enable = true;
      test.enable = true;
    };
  };

  # services = {
  #   pcscd.enable = true;
  # };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment? 🤨
}