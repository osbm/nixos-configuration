{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    enableKDE = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable KDE Plasma Desktop Environment with my favorite packages";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.enableKDE {
      # Enable the X11 windowing system.
      # You can disable this if you're only using the Wayland session.
      services.xserver.enable = true;

      # Enable the KDE Plasma Desktop Environment.
      services.displayManager.sddm = {
        enable = true;
        theme = "sugar-dark";
        wayland.enable = true;
      };
      services.desktopManager.plasma6.enable = true;

      environment.plasma6.excludePackages = [
        pkgs.kdePackages.kate
        pkgs.kdePackages.konsole
      ];

      # Enable CUPS to print documents.
      services.printing.enable = true;

      environment.systemPackages = with pkgs; [
        sddm-sugar-dark
        vscode
        discord # discord sucks
        alacritty
        obsidian
        mpv
        libreoffice
        blender
        gimp
        kitty
        obs-studio
        audacity
        qbittorrent
        ani-cli
        prismlauncher
        qbittorrent
      ];

      programs.steam = {
        enable = true;
        # Open ports in the firewall for Steam Remote Play
        remotePlay.openFirewall = true;
        # Open ports in the firewall for Source Dedicated Server
        dedicatedServer.openFirewall = true;
        # Open ports in the firewall for Steam Local Network Game Transfers
        localNetworkGameTransfers.openFirewall = true;
      };
    })
  ];
}
