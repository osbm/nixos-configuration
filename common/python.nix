{ pkgs, lib, config, ... }: {


  environment.systemPackages = with pkgs; [
    (pkgs.python312.withPackages (ppkgs: [
      python312Packages.pip
      python312Packages.torch
      python312Packages.ipython
      python312Packages.numpy
      python312Packages.pandas
      python312Packages.seaborn
      python312Packages.matplotlib
      python312Packages.jax
    ]))
    pyenv
  ];


}
