{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.update = {
    enable = lib.mkEnableOption "";
    repo = lib.mkOption {
      type = types.str;
    };
    host = lib.mkOption {
      type = types.str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.update.enable {
    # Install git
    environment.systemPackages = with pkgs; [
      git
    ];

    # Add shell command
    environment.shellAliases = {
      "update" = ''
        cd /etc/nixos && \
        sudo git pull || \
        sudo git clone $(config.modules.update.repo) . && \
        sudo nixos-rebuild switch --flake .#${config.modules.update.host}
      '';
    };
  };

}
