{...}:
let
  # define a block that just takes a hostname and returns attrset to not repeat the same fields
  sshBlock = hostname: {
    hostname = hostname;
    user = "osbm";
    identityFile = "/home/osbm/.ssh/id_ed25519";
    extraOptions = { # [ERROR] - (starship::print): Under a 'dumb' terminal (TERM=dumb).
      "RemoteCommand" = "fish";
      "RequestTTY" = "force";
    };
  };
in
{
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    compression = true;
    matchBlocks = {
      ymir = sshBlock "192.168.0.2";
      ymir-ts = sshBlock "ymir.curl-boga.ts.net";
      atreus = sshBlock "192.168.0.3";
      atreus-ts = sshBlock "atreus.curl-boga.ts.net";
      tartarus = sshBlock "192.168.0.4";
      tartarus-ts = sshBlock "tartarus.curl-boga.ts.net";
      pochita = sshBlock "192.168.0.9";
      pochita-ts = sshBlock "pochita.curl-boga.ts.net";
    };
  };
}
