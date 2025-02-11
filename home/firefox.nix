{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.osbm = {
        id = 0;
        name = "osbm";
    };
  };
}