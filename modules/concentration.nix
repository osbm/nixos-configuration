{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    blockYoutube = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Disables youtube using /etc/hosts file";
    };
    blockTwitter = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Disables twitter using /etc/hosts file";
    };
    blockBluesky = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Disables bluesky using /etc/hosts file";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.blockYoutube {
      networking.extraHosts = ''
        0.0.0.0   youtube.com
        ::0       youtube.com

        0.0.0.0   www.youtube.com
        ::0       www.youtube.com
      '';
    })
    (lib.mkIf config.blockTwitter {
      networking.extraHosts = ''
        0.0.0.0   twitter.com
        ::0       twitter.com

        0.0.0.0   www.twitter.com
        ::0       www.twitter.com
      '';
    })
    (lib.mkIf config.blockBluesky {
      networking.extraHosts = ''
        0.0.0.0  bsky.app
        ::0      bsky.app

        0.0.0.0  www.bsky.app
        ::0      www.bsky.app
      '';
    })
  ];
}
