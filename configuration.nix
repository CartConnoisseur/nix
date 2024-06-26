{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  fileSystems."/persist".neededForBoot = true;
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
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "c" = import ./home.nix;
    };
  };

  environment = {
    localBinInPath = true;

    interactiveShellInit = ''
      alias ssh="kitty +kitten ssh"

      alias lsa="ls -lAsh"
      alias c="codium ."
      alias p="nix-shell -p"

      mkcd() {
        mkdir -p "$1"
        cd "$1"
      }
    '';

    variables = {
      EDITOR = "${pkgs.vim}/bin/vim";
    };
  };

  time.timeZone = "America/Los_Angeles";

  users.users = {
    root.hashedPasswordFile = "/persist/secrets/passwords/root";

    "c" = {
      isNormalUser = true;
      hashedPasswordFile = "/persist/secrets/passwords/c";
      extraGroups = [ "wheel" ];
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
  ];

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "rb" "sudo nixos-rebuild switch --flake /etc/nixos#default")
    (writeShellScriptBin "rbf" "sudo nixos-rebuild switch --flake path:/etc/nixos#default")
    (writeShellScriptBin "toys" "nix-shell -p cmatrix asciiquarium pipes cowsay figlet neofetch")

    git
    vim
    wget
    firefox
    wineWowPackages.stable
    winetricks

    pulseaudio
    playerctl

    ffmpeg
    jellyfin
  
    killall

    go
    jdk21

    lutris
    libGL
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
  };

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

