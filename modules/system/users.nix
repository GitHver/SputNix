{ pkgs
, lib
, alib
, config
, ...
}:

let
  inherit (builtins) attrNames removeAttrs concatMap;
  inherit (lib) mkOption;
  inherit (lib.types) attrs;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (alib) attrsFromList;
  cfg = config.users.userGroups;
in {

  options = {
    users.userGroups = mkOption {
      type = attrs;
      default = {};
    };
  };

  config = {
    users.users =
      attrNames cfg
      # results in:
      # [
      #   "guests"
      #   "admins"
      #   ... # Other usersGroups you create
      # ]
      |> concatMap (userGroup:
        listFilesRecursive cfg.${userGroup}.fromDirectory
        # results in:
        # [
        #   /nix/store/abc...z/hosts/THIS_MACHINE/USERDIR/guest1.nix
        #   /nix/store/abc...z/hosts/THIS_MACHINE/USERDIR/guest2.nix
        #   ...
        # ]
        |> map (userPath: import userPath) # importEach
        # results in:
        # [
        #   { un = "guest1"; dn = "Guest 1"; }
        #   { un = "guest2"; dn = "Guest 2"; }
        #   ...
        # ]
        |> map (user: {
            ${user.un} = (removeAttrs cfg.${userGroup} ["fromDirectory"])
            // { name = user.un; description = user.dn; };
        })
        # results in:
        # [
        #   [
        #     { guest1 = { guestsettings }; }
        #     { guest2 = { guestsettings }; }
        #   ]
        #   [...] # more after each map of `userGroups`
        # ]
      )
      # results in:
      # [
      #   { guest1 = { guestsettings }; }
      #   { guest2 = { guestsettings }; }
      #   { admin1 = { adminsettings }; }
      #   ...
      # ]
      # because `concatMap` already removes the nested lists.
      |> attrsFromList
      # results in:
      # {
      #   admin1 = { adminsettings };
      #   guest1 = { guestsettings };
      #   guest2 = { guestsettings };
      #   ...
      # }
    ;
  };

}
