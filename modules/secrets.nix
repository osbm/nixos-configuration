{
  age.secrets = {
    network-manager.file = ../secrets/network-manager.age;
    ssh-key-private = {
      file = ../secrets/ssh-key-private.age;
      path = "/home/osbm/.ssh/id_ed25519";
      mode = "0600";
    };
    ssh-key-public = {
      file = ../secrets/ssh-key-public.age;
      path = "/home/osbm/.ssh/id_ed25519.pub";
      mode = "0644";
    };
  };
}
