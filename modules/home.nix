{
  config,
  pkgs,
  stateVersion,
  ...
}: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "osbm";
  home.homeDirectory = "/home/osbm";

  # Packages that should be installed to the user profile.
  home.packages = [
  ];

  programs.git = {
    enable = true;
    userEmail = "osmanfbayram@gmail.com";
    userName = "osbm";
  };

  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    compression = true;

    matchBlocks = {
      "tartarus" = {
        hostname = "192.168.0.4";
        user = "osbm";
        identityFile = "/home/osbm/.ssh/id_ed25519";
        # setEnv = {
        #   "TERM" = "xterm-256color";
        # };
        # extraOptions = {   # [ERROR] - (starship::print): Under a 'dumb' terminal (TERM=dumb).
        #   "RemoteCommand" = "fish";
        # };
      };
      "ymir" = {
        hostname = "192.168.0.2";
        user = "osbm";
        identityFile = "/home/osbm/.ssh/id_ed25519";
        # setEnv = {
        #   "TERM" = "xterm-256color";
        # };
        # extraOptions = { # TODO fix the damn starship error
        #   "RemoteCommand" = "fish";
        # };
      };
      "pochita" = {
        hostname = "192.168.0.9";
        user = "osbm";
        identityFile = "/home/osbm/.ssh/id_ed25519";
      };
    };
  };
  programs.tmux = {
    enable = true;
    historyLimit = 100000;
    baseIndex = 1;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.dracula
    ];
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = stateVersion;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
