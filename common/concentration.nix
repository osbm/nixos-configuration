{ pkgs, lib, config, ... }: {

  networking.extraHosts =
  ''
    0.0.0.0   youtube.com
    ::0       youtube.com

    0.0.0.0   www.youtube.com
    ::0       www.youtube.com
  '';
}
