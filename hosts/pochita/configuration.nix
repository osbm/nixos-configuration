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
  enableFonts = false;

  blockYoutube = false;
  blockTwitter = false;

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

  services.openssh.settings.GatewayPorts = "yes";

  system.nixos.label = system-label;
  # DO NOT TOUCH THIS
  system.stateVersion = stateVersion;
}
