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
      ExtensionSettings = with builtins;
        let extension = shortId: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "normal_installed";
          };
        };
        in listToAttrs [
          (extension "tree-style-tab" "treestyletab@piro.sakura.ne.jp")
          # (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          # (extension "tabliss" "extension@tabliss.io")
          # (extension "umatrix" "uMatrix@raymondhill.net")
          # (extension "libredirect" "7esoorv3@alefvanoon.anonaddy.me")
          # (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
        ];
        # To add additional extensions, find it on addons.mozilla.org, find
        # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # Then, download the XPI by filling it in to the install_url template, unzip it,
        # run `jq .browser_specific_settings.gecko.id manifest.json` or
        # `jq .applications.gecko.id manifest.json` to get the UUID
    };
    };
  };



}
