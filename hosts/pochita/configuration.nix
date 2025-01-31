# This is the SD image initial configuration
{
  config,
  pkgs,
  lib,
  system-label,
  ...
}: let
  stateVersion = "25.05";
in {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "192.168.0.2";
      systems = [ "x86_64-linux" "aarch64-linux" ];
      supportedFeatures = [ "big-parallel" "kvm"];
      sshKey = "/home/osbm/.ssh/id_ed25519";
      sshUser = "osbm";
    }
  ];

  enableKDE = false;
  enableFonts = false;

  blockYoutube = false;
  blockTwitter = false;

  enableTailscale = true;

  i18n.inputMethod.enable = lib.mkForce false; # no need for japanese input method
  programs.firefox.enable = lib.mkForce false; # no need for firefox

  networking.hostName = "pochita";
  # log of shame: osbm blamed nix when he wrote "hostname" instead of "hostName"

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.osbm = import ../../modules/home.nix {
    inherit config pkgs stateVersion;
  };

  environment.systemPackages = with pkgs; [
  ];

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  services.getty.autologinUser = "osbm";

  # The board and wanted kernel version
  raspberry-pi-nix = {
    board = "bcm2712";
    #kernel-version = "v6_10_12";
  };


  system.nixos.label = system-label;
  # DO NOT TOUCH THIS
  system.stateVersion = stateVersion;
}
