{pkgs, lib, config, inputs, outputs, ... }:

{

  imports = [
    ./../../modules/nvidia.nix    # for if you have a nvidia gpu
  ];

}
