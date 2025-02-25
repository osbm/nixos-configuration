{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./sd-image.nix
    ../../modules
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];

  myModules = {
    enableKDE = false;
    enableFonts = false;
    blockYoutube = false;
    blockTwitter = false;
    enableTailscale = true;
  };

  i18n.inputMethod.enable = lib.mkForce false; # no need for japanese input method


  # Some packages (ahci fail... this bypasses that) https://discourse.nixos.org/t/does-pkgs-linuxpackages-rpi3-build-all-required-kernel-modules/42509
  nixpkgs.overlays = [
    (final: super: {
      makeModulesClosure = x:
        super.makeModulesClosure (x // {allowMissing = true;});
    })
  ];

  nixpkgs.hostPlatform = "aarch64-linux";
  # ! Need a trusted user for deploy-rs.
  system.stateVersion = "25.05";

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  sdImage = {
    # bzip2 compression takes loads of time with emulation, skip it. Enable this if you're low on space.
    compressImage = false;
    imageName = "zero2.img";

    extraFirmwareConfig = {
      # Give up VRAM for more Free System Memory
      # - Disable camera which automatically reserves 128MB VRAM
      start_x = 0;
      # - Reduce allocation of VRAM to 16MB minimum for non-rotated (32MB for rotated)
      gpu_mem = 16;

      # Configure display to 800x600 so it fits on most screens
      # * See: https://elinux.org/RPi_Configuration
      hdmi_group = 2;
      hdmi_mode = 8;
    };
  };

  hardware = {
    enableRedistributableFirmware = lib.mkForce false;
    firmware = [pkgs.raspberrypiWirelessFirmware]; # Keep this to make sure wifi works
    i2c.enable = true;
    deviceTree.filter = "bcm2837-rpi-zero*.dtb";
    deviceTree.overlays = [
      {
        name = "enable-i2c";
        dtsText = ''
          /dts-v1/;
          /plugin/;
          / {
            compatible = "brcm,bcm2837";
            fragment@0 {
              target = <&i2c1>;
              __overlay__ {
                status = "okay";
              };
            };
          };
        '';
      }
    ];
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_rpi02w;

    initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    # Avoids warning: mdadm: Neither MAILADDR nor PROGRAM has been set. This will cause the `mdmon` service to crash.
    # See: https://github.com/NixOS/nixpkgs/issues/254807
    swraid.enable = lib.mkForce false;
  };

  # networking = {
  #   interfaces."wlan0".useDHCP = true;
  #   wireless = {
  #     enable = true;
  #     interfaces = ["wlan0"];
  #     # ! Change the following to connect to your own network
  #     networks = {
  #       "${config.age.secrets.home-wifi-ssid.}" = {
  #         psk = "${secrets.home-wifi-password.age}";
  #       };
  #     };
  #   };
  # };
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      config.age.secrets.nm-secrets.path
    ];

    profiles = {
      House_Bayram = {
        connection = {
          id = "House_Bayram";
          type = "wifi";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "stable-privacy";
          method = "auto";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "House_Bayram";
        };
        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$HOME_WIFI";
        };
      };
      it_hurts_when_IP = {
        connection = {
          id = "it_hurts_when_IP";
          type = "ethernet";
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "stable-privacy";
          method = "auto";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "it_hurts_when_IP";
        };
        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$HOME_WIFI";
        };
      };
    };
  };

  # NTP time sync.
  services.timesyncd.enable = true;


  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
  services.getty.autologinUser = "osbm";
}
