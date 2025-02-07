{
  config,
  pkgs,
  ...
}: {

  options = {
    myModules.enableJellyfin = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Jellyfin media server";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.myModules.enableJellyfin {
      services.jellyfin = {
        enable = true;
        openFirewall = true;

      };

      networking.firewall.allowedTCPPorts = [8096];
    })
  ];

}