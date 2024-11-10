{ pkgs, lib, config, ... }: {

  environment.systemPackages = with pkgs; [
    arduino-ide
    adafruit-nrfutil
  ];

  services.udev.extraRules = ''
    KERNEL=="ttyACM0", MODE="0666"
  '';

}
