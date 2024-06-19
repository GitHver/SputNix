{ config, lib, ... }:

{

# ==== Internationalisation properties. ====================================== #
  options.locale-all = lib.mkOption {
    default = "en_GB.UTF-8";
  };

  config.i18n = {
    defaultLocale = "en_GB.UTF8";
    extraLocaleSettings = {
      LC_ADDRESS =        "${config.locale-all}";
      LC_IDENTIFICATION = "${config.locale-all}";
      LC_MEASUREMENT =    "${config.locale-all}";
      LC_MONETARY =       "${config.locale-all}";
      LC_NAME =           "${config.locale-all}";
      LC_NUMERIC =        "${config.locale-all}";
      LC_PAPER =          "${config.locale-all}";
      LC_TELEPHONE =      "${config.locale-all}";
      LC_TIME =           "${config.locale-all}"; 
    };
  };

}
