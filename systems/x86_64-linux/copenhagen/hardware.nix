{ config, lib, pkgs, modulesPath, ... }:

{
  cxl.hardware = {
    boot.rollback.zfs = {
      #TODO: re-enable impermanence
      enable = false;

      volumes = [
        "zpool/root@blank"
        "zpool/home@blank"
      ];
    };
  };

  #TODO: deduplicate
  systemd.services = {
    "cxl.init.set-secrets-mode" = {
      after = [ "secrets.mount" ];
      before = [ "local-fs.target" ];

      requires = [ "secrets.mount" ];
      requiredBy = [ "initrd.target" ];

      script = ''
        chmod u=rw,g=,o= /secrets
      '';

      serviceConfig = {
        Type = "oneshot";
      };
    };
  };

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
    };

    zfs.forceImportRoot = false;

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
