# This is the SD image initial configuration
{
  config,
  pkgs,
  lib,
  ...
}: let
  stateVersion = "25.05";
in {
  imports = [
    ../../modules
  ];

  enableKDE = false;

  blockYoutube = false;
  blockTwitter = false;


  #   # Some programs
  environment.systemPackages = with pkgs; [
    #     vim
    #     wget
    #     git
    #     htop
  ];

  # Experimental features must be activated
  #   nix.settings = {
  #     trusted-users = [ "@wheel" ];
  #     experimental-features = [ "nix-command" "flakes" ];
  #     keep-outputs = true;
  #     keep-derivations = true;
  #   };


  # You can put another features here, for example:
  #security.rtkit.enable = true;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;
  #};
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };


  services.getty.autologinUser = "osbm";
  # networking.hostname = "pochita";
   # The board and wanted kernel version
  raspberry-pi-nix = {
    board = "bcm2712";
    #kernel-version = "v6_10_12";
  };

  # DO NOT TOUCH THIS
  system.stateVersion = stateVersion;
}
