{ ... }:

{
  #====<< User management >>====================================================>
  users.mutableUsers = true; # Allows for imperative user management.
  users.userGroups = {
    "admins" = {
      # The directory from which to source the users.
      fromDirectory = ./users;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "nixers"
        "networkmanager"
      ];
      # Initial password is needed as COSMIC greeter does not support
      # passwordless login yet.
      initialPassword = "asdf";
      # This makes it so that user systemd services are started on boot rather
      # than on login. This can be useful if you have many users all using
      # standalone home-manager, with some not using the computer frequently.
      # With this on, the garbage collector for each user is active ensuring
      # that each user only has the generation they are currently using as to
      # save disk space.
      linger = true;
    };
  };
}
