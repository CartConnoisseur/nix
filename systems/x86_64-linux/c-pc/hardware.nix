{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
    loader.grub = {
      enable = true;

      useOSProber = true;

      zfsSupport = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      
      mirroredBoots = [
        { devices = [ "nodev" ]; path = "/boot"; }
      ];
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ "amdgpu" ];

      #TODO: re-enable impermanence
      # postDeviceCommands = lib.mkAfter ''
      #   zfs rollback -r zpool/root@blank && zfs rollback -r zpool/home@blank
      # '';

      postMountCommands = lib.mkAfter ''
        chmod u=rw,g=,o= /secrets
      '';
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];

    supportedFilesystems = [ "ntfs" ];
  };

  fileSystems = {
    "/"               = { fsType = "zfs"; neededForBoot = true; device = "zpool/root"; };
    "/nix"            = { fsType = "zfs"; neededForBoot = true; device = "zpool/nix";  };
    "/home"           = { fsType = "zfs"; neededForBoot = true; device = "zpool/home"; };
    "/persist"        = { fsType = "zfs"; neededForBoot = true; device = "zpool/persist"; };
    "/persist/secure" = { fsType = "zfs"; neededForBoot = true; device = "zpool/secure/persist"; };
    "/secrets"        = { fsType = "zfs"; neededForBoot = true; device = "zpool/secure/secrets"; };

    "/boot"           = { fsType = "vfat"; device = "/dev/disk/by-uuid/12CE-A600"; };

    "/mnt/4tb"        = { fsType = "ext4"; device = "/dev/disk/by-label/4tb"; };
  };

  swapDevices = [ ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  nixpkgs.hostPlatform = "x86_64-linux";
}
