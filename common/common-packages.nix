{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # vim
    wget
    git
    git-lfs
    gnumake
    zip
    fish
    trash-cli
    tmux
    zoxide
    htop
    unzip
    tlrc
    wakeonlan
    # neovim
    pkgs-unstable.ani-cli
    btop
    pciutils
    nodePackages.npm
    nodejs
    cloc
    neofetch
    cbonsai
    cowsay
    fortune
    lolcat
    cmatrix
    inxi
    age
    sops
    jq
    onefetch
    just
    gh
    starship
    tree
    ffmpeg
    nix-output-monitor
    yazi
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

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    silent = false;
    loadInNixShell = true;
    direnvrcExtra = "";
    nix-direnv = {
      enable = true;
      package = pkgs.nix-direnv;
    };
  };
}
