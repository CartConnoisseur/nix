{ config, lib, pkgs, modulesPath, ... }:

{
  boot = {
    loader.grub = {
      enable = true;

      zfsSupport = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      
      mirroredBoots = [
        { devices = [ "nodev" ]; path = "/boot"; }
      ];
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];

      #TODO: re-enable impermanence
      # postDeviceCommands = lib.mkAfter ''
      #   zfs rollback -r zpool/root@blank && zfs rollback -r zpool/home@blank
      # '';

      postMountCommands = lib.mkAfter ''
        chmod u=rw,g=,o= /secrets
      '';
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    supportedFilesystems = [ "ntfs" ];
  };

  fileSystems = {
    "/"        = { fsType = "zfs"; neededForBoot = true; device = "zpool/root"; };
    "/nix"     = { fsType = "zfs"; neededForBoot = true; device = "zpool/nix";  };
    "/home"    = { fsType = "zfs"; neededForBoot = true; device = "zpool/home"; };
    "/persist" = { fsType = "zfs"; neededForBoot = true; device = "zpool/persist"; };
    "/secrets" = { fsType = "zfs"; neededForBoot = true; device = "zpool/secrets"; };

    "/boot"    = { fsType = "vfat"; device = "/dev/disk/by-uuid/DF61-E3BD"; };

    "/mnt/old" = { fsType = "ext4"; device = "/dev/disk/by-label/box"; };
  };

  swapDevices = [ ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  nixpkgs.hostPlatform =  "x86_64-linux";
}
