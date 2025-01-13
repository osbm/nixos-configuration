{
  pkgs,
  lib,
  config,
  ...
}: {
  users.users = {
    osbm = {
      isNormalUser = true;
      description = "osbm";
      extraGroups = ["networkmanager" "wheel" "docker"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPfnV+qqUCJf92npNW4Jy0hIiepCJFBDJHXBHnUlNX0k"
      ];
      packages = with pkgs; [
      ];
    };
    bayram = {
      isNormalUser = true;
      description = "bayram";
      initialPassword = "changeme";
      extraGroups = ["networkmanager"];
      packages = with pkgs; [
      ];
    };
  };
}
