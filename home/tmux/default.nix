{
  config,
  pkgs,
  ...
}: let
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
      maintainers = with maintainers; [ethancedwards8];
    };
  };
in {
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
          set -g @dracula-plugins "custom:wanikani.sh cpu-usage ram-usage gpu-usage battery time"
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
}
