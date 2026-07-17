let
  hack = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJkbFakrsJM7oY9eOi8t7X0wsz6WSAX1U0iqLhxopqQ";
 
in{
    "secret1.age".publicKeys = [hack];
}