let
  ymir = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxc1ycxtzO2u4bHas71pi5CpR8Zzcj6GXjx1lLWMOHq";
  tartarus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMxbIyQnQFA1RFQKH4eHHWcT7Z0tCumerCsRMjlHgSPd";

  machines = [
    ymir
    tartarus
  ];
in {
  ymir = ymir;
  tartarus = tartarus;

  "home-wifi-ssid.age".publicKeys = machines;
  "home-wifi-password.age".publicKeys = machines;
}
