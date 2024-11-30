{ pkgs, lib, config, ... }: {

  # Install firefox.
  programs.firefox = {
    enable = true;
    languagePacks = [ "ja" "tr" "en-US" ];

    # profiles.osbm = {


    # Check about:policies#documentation for options.
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      # DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      StartPage = "previous-session";
      # OverrideFirstRunPage = "";
      # OverridePostUpdatePage = "";
      # DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always"; # alternatives: "never" or "newtab"
      # DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      # SearchBar = "unified"; # alternat
    };
  };



}
