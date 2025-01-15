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

  enableKDE = false;

  blockYoutube = false;
  blockTwitter = false;

  # networking.hostname = "pochita"; # why setting hostname gives me an error?

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.osbm = import ../../modules/home.nix {
    inherit config pkgs stateVersion;
  };

  #   # Some programs
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
