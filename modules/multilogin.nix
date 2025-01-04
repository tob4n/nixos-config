{ config, lib, pkgs, ... }: {
  options = {
    modules.multilogin = {
      enable = lib.mkEnableOption "";
      sessions = lib.mkOption {
        type = with lib.types; listOf str;
      };
    };
  };

  config = lib.mkIf config.modules.multilogin.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = lib.head config.modules.multilogin.sessions;
          user = "user";
        };
      };
    };

    environment.etc = lib.listToAttrs (lib.imap1 (index: command: {
      name = "greetd/session${toString index}-config.toml";
      value = {
        text = ''
          [terminal]
          vt = ${toString (index + 1)}

          [default_session]
          command = "${command}"
          user = "user"
        '';
      };
    }) (lib.tail config.modules.multilogin.sessions));

    systemd.services = lib.listToAttrs (lib.imap1 (index: command: {
      name = "greetd-session${toString index}";
      value = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.greetd.greetd}/bin/greetd --config /etc/greetd/session${toString index}-config.toml";
          Restart = "always";
        };
      };
    }) (lib.tail config.modules.multilogin.sessions));
  };

}
