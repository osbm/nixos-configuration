{
  config,
  pkgs,
  stateVersion,
  ...
}:
let
  wanikani-script = builtins.path {
    path = ./wanikani-tmux.sh;
  };
  tmux-dracula = pkgs.tmuxPlugins.mkTmuxPlugin rec {
    pluginName = "dracula";
    version = "3.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "tmux";
      rev = "v${version}";
      hash = "sha256-VY4PyaQRwTc6LWhPJg4inrQf5K8+bp0+eqRhR7+Iexk=";
    };
    postInstall = ''
      # i am adding my custom widget to the plugin here cp the wanikani.sh script to the plugin directory
      cp ${wanikani-script} $target/scripts/wanikani.sh
    '';
    meta = with pkgs.lib; {
      homepage = "https://draculatheme.com/tmux";
      description = "Feature packed Dracula theme for tmux!";
      license = licenses.mit;
      platforms = platforms.unix;
      maintainers = with maintainers; [ ethancedwards8 ];
    };
  };

in
{
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
    shortcut = "s";
    mouse = true;
    shell = "${pkgs.fish}/bin/fish";
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.better-mouse-mode
      {
        plugin = tmux-dracula;
        extraConfig = ''
        set -g @dracula-plugins "custom:wanikani cpu-usage ram-usage gpu-usage battery time"
        set -g @dracula-show-left-icon hostname
        set -g @dracula-git-show-current-symbol ✓
        set -g @dracula-git-no-repo-message "no-git"
        set -g @dracula-show-timezone false
        set -g @dracula-ignore-lspci true
        '';
      }
    ];
    extraConfig = ''
      # Automatically renumber windows
      set -g renumber-windows on
    '';
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
