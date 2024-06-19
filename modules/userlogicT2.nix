{ lib, ... }:

{
# ==== User management ======================================================= #
  users.users = let
    inherit (lib.lists) foldl forEach;
    hostname = import ./../hostname.nix;
    guests = import ./../archive/${hostname}/userlistT2.nix; 
  in

  foldl (a: b: a // b) { }

    (forEach guests (guest: {

      ${guest} = {
	isNormalUser = true;
	#home = "home/${user}";
	description = "${guest}";
	initialPassword = "09i98u87y";
	extraGroups = [ "networkmanager" ];
      };

    } ) );

}
