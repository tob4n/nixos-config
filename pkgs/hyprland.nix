{ config, lib, pkgs, ... }: {

  # Enable Hyprland and waybar
  programs = {
    hyprland = {
      enable = true;
      withUWSM = false;
    };
    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
         mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
  };

  # Install desktop utilities
  environment.systemPackages = with pkgs; [
    dunst
    kitty
    rofi-wayland
  ];

}
