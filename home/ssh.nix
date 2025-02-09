{pkgs, ...}: {
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
      "pochita-tailscale" = {
        hostname = "pochita.curl-boga.ts.net";
        user = "osbm";
        identityFile = "/home/osbm/.ssh/id_ed25519";
      };
      "ymir-tailscale" = {
        hostname = "ymir.curl-boga.ts.net";
        user = "osbm";
        identityFile = "/home/osbm/.ssh/id_ed25519";
      };
      "tartarus-tailscale" = {
        hostname = "tartarus.curl-boga.ts.net";
        user = "osbm";
        identityFile = "/home/osbm/.ssh/id_ed25519";
      };
    };
  };
}
