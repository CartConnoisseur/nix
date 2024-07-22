{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

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

      postDeviceCommands = lib.mkAfter ''
        zfs rollback -r zpool/root@blank && zfs rollback -r zpool/home@blank
      '';
    };

    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];

    supportedFilesystems = [ "ntfs" ];
  };

  fileSystems = {
    "/"        = { fsType = "zfs"; device = "zpool/root"; };
    "/home"    = { fsType = "zfs"; device = "zpool/home"; };
    "/persist" = { fsType = "zfs"; device = "zpool/persist"; };
    "/secrets" = { fsType = "zfs"; device = "zpool/secrets"; };
    "/nix"     = { fsType = "zfs"; device = "zpool/nix"; };

    "/boot"    = { fsType = "vfat"; device = "/dev/disk/by-uuid/DF61-E3BD"; };

    "/mnt/old" = { fsType = "ext4"; device = "/dev/disk/by-label/box"; };
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
