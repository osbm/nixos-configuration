let
  ymir = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxc1ycxtzO2u4bHas71pi5CpR8Zzcj6GXjx1lLWMOHq";
  tartarus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMxbIyQnQFA1RFQKH4eHHWcT7Z0tCumerCsRMjlHgSPd";

  machines = [
    ymir
    tartarus
  ];
in {
  "network-manager.age".publicKeys = machines;
  "ssh-key-private.age".publicKeys = machines;
  "ssh-key-public.age".publicKeys = machines;
}
