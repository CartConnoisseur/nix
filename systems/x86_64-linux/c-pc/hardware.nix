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

  services = {
    xserver.videoDrivers = [ "amdgpu" ];
    
    autorandr = {
      enable = true;
      matchEdid = true;

      profiles = {
        "widescreen" = {
          fingerprint = {
            DVI-D-0       = "00ffffffffffff0010ac71f0494a4641211a010380301b78ea8ef5a25750a2270c5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c4500dc0c1100001e000000ff003047574e5236384141464a490a000000fc0044454c4c20534532323136480a000000fd00384c1e5311000a20202020202001a1020317b14c901f0102030712160413140565030c001000023a801871382d40582c4500dc0c1100001e011d8018711c1620582c2500dc0c1100009e011d007251d01e206e285500dc0c1100001e8c0ad08a20e02d10103e9600dc0c110000180000000000000000000000000000000000000000000000000000000000000000b9";
            DisplayPort-2 = "00ffffffffffff0006b3e032dde40400271e0104b54627783b1be5ad5047a526125054bfcf00d1c0714f81c0814081809500b3000101e6f90050a0a01e5008200804b9882100001a695e00a0a0a029503020b804b9882100001a000000fd0030a5fafa41010a202020202020000000fc004153555320564733325651314201ea020333714d0102031112130f1d1e0e901f0423091707830100006d1a0000020130a5000000000000e305e000e60607014a4a745aa000a0a0a0465030203500b9882100001a6fc200a0a0a0555030203500b9882100001a59e7006aa0a0675015203500b9882100001efa7e80887038124018203500b9882100001e00000000b8";
            DisplayPort-1 = "00ffffffffffff0010ac17f04c4e433628140104b53420783a1ec5ae4f34b1260e5054a54b008180a940d100714f0101010101010101283c80a070b023403020360006442100001a000000ff00433539324d30395536434e4c0a000000fc0044454c4c2055323431300a2020000000fd00384c1e5111000a202020202020019902031df15090050403020716011f121314201511062309070783010000023a801871382d40582c450006442100001e011d8018711c1620582c250006442100009e011d007251d01e206e28550006442100001e8c0ad08a20e02d10103e9600064421000018000000000000000000000000000000000000000000000000000021";
          };

          config = {
            # left
            DVI-D-0 = {
              enable = true;
              crtc = 2;

              mode = "1920x1080";
              rate = "60.00";
              position = "0x360";
            };

            # center
            DisplayPort-2 = {
              enable = true;
              primary = true;
              crtc = 0;

              mode = "2560x1440";
              rate = "165.00";
              position = "1920x0";
            };

            # right
            DisplayPort-1 = {
              enable = true;
              crtc = 1;

              mode = "1920x1200";
              rate = "60.00";
              position = "4480x0";
            };
          };
        };

        "ultrawide" = {
          fingerprint = {
            DVI-D-0       = "00ffffffffffff0010acdca042595231061b010380351e78ea0565a756529c270f5054a54b00714f8180a9c0d1c00101010101010101023a801871382d40582c45000f282100001e000000ff00464d584e52373241315259420a000000fc0044454c4c205032343137480a20000000fd00384c1e5311000a2020202020200154020317b14c9005040302071601141f121365030c001000023a801871382d40582c45000f282100001e011d8018711c1620582c25000f282100009e011d007251d01e206e2855000f282100001e8c0ad08a20e02d10103e96000f282100001800000000000000000000000000000000000000000000000000000000000000003d";
            DisplayPort-2 = "00ffffffffffff001e6df25979470000091a0104a55022789eca95a6554ea1260f5054a54b80714f818081c0a9c0b3000101010101017e4800e0a0381f4040403a001e4e31000018023a801871382d40582c45001e4e3100001a000000fc004c4720554c545241574944450a000000fd00384b1e5a18000a202020202020016a02031c71499004030012001f0113230907078301000065030c001000023a801871382d40582c450056512100001e011d8018711c1620582c2500a5222100009e011d007251d01e206e285500a5222100001e8c0ad08a20e02d10103e9600a52221000018000000000000000000000000000000000000000000000000000000d5";
            HDMI-A-0      = "00ffffffffffff004e14ab0901000000021e010380351d782a5855b04e46a725135054bfef00d1c0b30095008180814081c001010101023a801871382d40582c450012222100001e2a4480a0703827403020350009252100001e000000fd00324c1e5314000a202020202020000000fc0053636570747265204632340a20010d020329f14b1f05140413031202110110230907078301000067030c002000382d681a00000101304ced2a4480a0703827403020350009252100001e011d007251d01e206e28550009252100001e8c0ad08a20e02d10103e96000925210000188c0ad090204031200c40550009252100001800000000000000000000000000006b";
          };

          config = {
            # left
            DVI-D-0 = {
              enable = true;
              crtc = 2;

              mode = "1920x1080";
              rate = "60.00";
              position = "0x0";
            };

            # center
            DisplayPort-2 = {
              enable = true;
              primary = true;
              crtc = 0;

              mode = "2560x1080";
              rate = "60.00";
              position = "1920x0";
            };

            # right
            HDMI-A-0 = {
              enable = true;
              crtc = 1;

              mode = "1920x1080";
              rate = "75.00";
              position = "4480x0";
            };
          };
        };
      };
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
