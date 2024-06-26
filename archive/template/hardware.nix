{pkgs, ... }:

{

 #====<< Import all device specific modules >>=================================>
  imports = [
    ./hardware-configuration.nix
    #./amd-drivers.nix      # If you have an AMD GPU
    #./nvidia-drivers.nix   # or If you have an Nvidia GPU
  ];

 #====<< Luks incryption >>====================================================>
  # if you are usiong encryption on your drives, you should put it here
  # it should look something lke this:
  /*
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };  # Setup keyfile
  # Enable swap on luks
  boot.initrd.luks.devices."luks-a-bunch-of-numbers-and-letters" = {
    device  = "/dev/disk/by-uuid/a-bunch-of-numbers-and-letters";
    keyFile = "/crypto_keyfile.bin";
  };
  */
}
