{ pkgs, lib, config, ... }: {

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # enable nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.trusted-users = [ "root", "osbm" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.nixPath = [ "nixpkgs=${pkgs.path}" ];


  # disable the database error TODO add nix-index search
  programs.command-not-found.enable = false;

}

