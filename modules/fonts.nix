{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    enableFonts = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable my favorite fonts";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.enableFonts {
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        mplus-outline-fonts.githubRelease
        dina-font
        nerd-fonts.fira-code
        nerd-fonts.ubuntu
        proggyfonts
        source-sans
        source-sans-pro
        source-serif-pro
        font-awesome
        font-awesome_5
        roboto
      ];
    })
  ];
}
