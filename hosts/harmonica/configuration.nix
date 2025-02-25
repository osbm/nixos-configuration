{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./sd-image.nix
    "${inputs.nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
    ./hardware-configuration.nix
    ../../modules
    inputs.agenix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.vscode-server.nixosModules.default
  ];

  myModules = {
    enableKDE = false;
    enableFonts = false;
    blockYoutube = false;
    blockTwitter = false;
    enableTailscale = true;
  };

  i18n.inputMethod.enable = lib.mkForce false; # no need for japanese input method

  system.stateVersion = "25.05";

  networking.hostName = "harmonica";

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
          psk = "$MOBILE_HOTSPOT";
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
