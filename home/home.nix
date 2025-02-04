{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./tmux
    ./git.nix
    ./ssh.nix
  ];

  home.username = "osbm";
  home.homeDirectory = "/home/osbm";

  home.packages = [
    # dont install packages here, just use normal nixpkgs
  ];

  home.stateVersion = config.system.stateVersion;
}
