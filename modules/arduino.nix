{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    arduinoSetup = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Installs arduino-ide and adafruit-nrfutil and sets udev rules";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.arduino {
      environment.systemPackages = with pkgs; [
        arduino-ide
        adafruit-nrfutil
        python3 # some arduino libraries require python3
      ];

      services.udev.extraRules = ''
        KERNEL=="ttyUSB[0-9]*",MODE="0666"
        KERNEL=="ttyACM[0-9]*",MODE="0666"
      '';
    })
  ];
}
