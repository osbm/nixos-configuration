# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-unstable,
  system-label,
  osbm-nvim,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/fonts.nix
    ../../common/nix-settings.nix
    ../../common/i18n.nix
    ../../common/python.nix
    ../../common/arduino.nix
    ../../common/firefox.nix
    ../../common/common-packages.nix
    ../../common/concentration.nix
  ];

  blockYoutube = true;

  services.cloudflare-warp.enable = true;

  services.vscode-server.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.osbm = import ./home.nix;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["osbm"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tartarus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.osbm = {
    isNormalUser = true;
    description = "osbm";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      kdePackages.kate
      vscode
      pkgs-unstable.discord # discord sucks
      alacritty
      pkgs-unstable.obsidian
      mpv
      libreoffice
      blender
      gimp
      kitty
      obs-studio
      audacity
      pkgs-unstable.qbittorrent
      pkgs-unstable.arduino-ide
    ];
  };

  environment.systemPackages = with pkgs; [
    osbm-nvim.packages.${system}.default
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  system.nixos.label = system-label;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
