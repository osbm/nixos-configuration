let
  ymir = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxc1ycxtzO2u4bHas71pi5CpR8Zzcj6GXjx1lLWMOHq";
in {
  "another-secret.age".publicKeys = [ymir];
  # "gpg.age".publicKeys = [ymir];
  "bayram.age".publicKeys = [ymir];
}
