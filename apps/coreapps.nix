{ config, lib, pkgs, ... }: {
  
  # Add applications
  environment.systemPackages = with pkgs; [
    firefox
    thunderbird
    loupe
    celluloid
    nautilus
    gnome-text-editor
    mission-center
    blackbox-terminal
    ungoogled-chromium
    git
  ];

  # Setup file associations
  xdg.mime.defaultApplications = {
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "application/pdf" = "firefox.desktop";
    "application/zip" = "nautilus.desktop";
    "application/gzip" = "nautilus.desktop";
    "application/x-rar" = "nautilus.desktop";
    "application/x-7z-compressed" = "nautilus.desktop";
    "text/*" = "gnome-text-editor.desktop";
    "image/*" = "loupe.desktop";
    "video/*" = "celluloid.desktop";
  };

}