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
        "networkmanager"
      ];
      # This makes it so that user systemd services are started on boot rather
      # than on login. This can be useful if you have many users all using
      # standalone home-manager, with some not using the computer frequently.
      # With this on, the garbage collector for each user is active ensuring
      # that each user only has the generation they are currently using as to
      # save disk space.
      linger = true;
      # password is: Null&Nix1312 The reason that the password is in a
      # hashed format is because this way you can have your git repository
      # public without exposing the default password of new users. To make a
      # hashed password, use: `mkpasswd -s` and then type your password,
      # then copy the hash and replace this hash with the new one.
      # initialHashedPassword =
      #   "$y$j9T$exX8G.UG6FWPaovI79bjC.$sJUZr3BYq6LUK0B0bN4VJ2mfpgZpFTFHVXsZAib6mxB";
    };
    # "guests" = {
    #   fromDirectory = ./guests;
    #   isNormalUser = true;
    #   extraGroups = [
    #     "networkmanager"
    #   ];
    #   # linger = true;
    # };
  };
}
