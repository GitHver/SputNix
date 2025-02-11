{ lib
, config
, ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.hardware.nvidia;
in {

  options.hardware.nvidia.enable = mkEnableOption ''
    NVIDIA GPU Drivers
  '';

  config = mkIf cfg.enable {

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];
    boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

  };

}
