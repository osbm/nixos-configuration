{
  pkgs,
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
    jq
    onefetch
    just
    gh
    starship
    tree
    ffmpeg
    nix-output-monitor
    yazi
    ripgrep
    nh
    comma
  ];

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

  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    settings = {
      PermitRootLogin = "no";

      # only allow key based logins and not password
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AuthenticationMethods = "publickey";
      PubkeyAuthentication = "yes";
      ChallengeResponseAuthentication = "no";
      UsePAM = false;

      # kick out inactive sessions
      ClientAliveCountMax = 5;
      ClientAliveInterval = 60;
    };
  };

  services.vscode-server.enable = true;
}
