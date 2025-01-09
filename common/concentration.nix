{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    blockYoutube = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Disables youtube using /etc/hosts file";
    };
    blockTwitter = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Disables twitter using /etc/hosts file";
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
  ];
}
