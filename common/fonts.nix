{ pkgs, lib, config, ... }: {

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    nerdfonts
    proggyfonts
    source-sans
    source-sans-pro
    source-serif-pro
    font-awesome
    font-awesome_5
  ];

}
