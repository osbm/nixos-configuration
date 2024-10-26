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
      python312Packages.jupyter
      python312Packages.jupyterlab
    ]))
    (pkgs.python311.withPackages (ppkgs: [
      python311Packages.pip
      python311Packages.torch
      python311Packages.ipython
      python311Packages.numpy
      python311Packages.pandas
      python311Packages.seaborn
      python311Packages.matplotlib
      python311Packages.jax
    ]))
    pyenv
  ];


}