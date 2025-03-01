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
      attrsFromList (
        concatMap (userGroup:
          map (user: {
              ${user.un} = (removeAttrs cfg.${userGroup} ["fromDirectory"])
              // { name = user.un; description = user.dn; };
          }) (map (userPath: import userPath) (listFilesRecursive cfg.${userGroup}.fromDirectory))
        ) (attrNames cfg)
      )
    ;
  };

}
