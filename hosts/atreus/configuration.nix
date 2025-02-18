{ config, lib, pkgs, ... }:

{
  #  user.userName = lib.mkForce "osbm"; # fuck i hate unmaintained projects
  environment.packages = with pkgs; [
    vim # or some other editor, e.g. nano or neovim

    # Some common stuff that people expect to have
    #procps
    #killall
    #diffutils
    findutils
    utillinux
    tzdata
    hostname
    man
    gnugrep
    #gnupg
    #gnused
    #gnutar
    #bzip2
    #gzip
    #xz
    zip
    unzip
    fish
    tmux
    nano
    ripgrep
    tailscale
    git
    openssh
  ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";
  #services.openssh.enable=true;
  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  #time.timeZone = "Europe/Berlin";
}