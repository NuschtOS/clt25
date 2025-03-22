{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  console.keyMap = "us";

  environment.systemPackages = with pkgs; [
    dig
    htop
    kdePackages.krfb
    ripgrep
    tree
  ];

  i18n.defaultLocale = "de_DE.UTF-8";

  networking = {
    hostName = "xyzbook";
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  programs = {
    firefox.enable = true;
    git.enable = true;
    vim.enable = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "mail+clt25@c3d2.de";
  };

  services = {
    autossh.sessions = [ {
      monitoringPort = 20000;
      name = "tunnel";
      user = "tunnel";
      extraArguments = "-N -R 8080:127.0.0.1:80 -R 8443:127.0.0.1:443 -R 2222:127.0.0.1:22 -o ClientAliveInterval=5 tunnel@clt25.nuschtos.de";
    } ];

    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    hedgedoc = {
      enable = true;
      settings = {
        domain = "hedgedoc.clt25.nuschtos.de";
        protocolUseSSL = true;
      };
    };

    mastodon = {
      enable = true;
      configureNginx = true;
      localDomain = "mastodon.clt25.nuschtos.de";
      smtp.fromAddress = "noreply@mastodon.clt25.nuschtos.de";
      streamingProcesses = 1;
      extraConfig.SINGLE_USER_MODE = "true";
    };

    nextcloud = {
      enable = true;
      config = {
        dbhost = "/run/postgresql";
        dbtype = "pgsql";
      };
      hostName = "nextcloud.clt25.nuschtos.de";
      config.adminpassFile = "/etc/nextcloud-admin-pass";
    };

    nginx = {
      enable = true;
      virtualHosts = {
        "clt25.nuschtos.de" = {
          enableACME = true;
          forceSSL = true;
          locations."/".root = ./html;
        };
        "hedgedoc.clt25.nuschtos.de" = {
          enableACME = true;
          forceSSL = true;
          locations."/".proxyPass = "http://[::1]:${toString config.services.hedgedoc.settings.port}";
        };
        "mastodon.clt25.nuschtos.de" = {
          enableACME = true;
          forceSSL = true;
        };
        "nextcloud.clt25.nuschtos.de" = {
          enableACME = true;
          forceSSL = true;
        };
      };
    };

    openssh.enable = true;

    postgresql = {
      enable = true;
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [ {
        name = "nextcloud";
        ensureDBOwnership = true;
      } ];
    };

    # KRDP doesn't work on Wayland and just produces a white screen
    xserver.enable = true;
  };

  time.timeZone = "Europe/Berlin";

  users.users = {
    "k-ot" = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;
    };
    tunnel = {
      isNormalUser = true;
      shell = "/run/current-system/sw/bin/nologin";
    };
  };

  system.stateVersion = "25.05";
}

