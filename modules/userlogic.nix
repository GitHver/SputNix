{ lib, ... }:

{
# ==== User management ======================================================= #
  users.users = let
    inherit (lib.lists) foldl forEach;
    hostname = import ./../hostname.nix;
    users = import ./../archive/${hostname}/userlist.nix; 
  in

  foldl (a: b: a // b) { }

    (forEach users (user: {

      ${user} = {
	      isNormalUser = true;
	      #home = "home/${user}";
	      description = "${user}";
	      initialPassword = "12w23e34r";
	      extraGroups = [ "wheel" "networkmanager" ];
      };

    } ) );

}
