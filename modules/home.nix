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
