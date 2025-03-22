{ lib, modulesPath, pkgs, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking = {
    firewall.allowedTCPPorts = [ 80 443 ];
    hostName = "proxy";

    # hetzner networking
    interfaces.enp1s0 = {
      ipv4.addresses = [
        { address = "138.199.231.159"; prefixLength = 32; }
      ];
      ipv6.addresses = [
        { address = "2a01:4f8:c010:820c::1"; prefixLength = 64; }
      ];
    };
    defaultGateway = { address = "172.31.1.1"; interface = "enp1s0"; };
    defaultGateway6 = { address = "fe80::1"; interface = "enp1s0"; };
    nameservers = [
      "213.133.98.98"
      "213.133.99.99"
      "213.133.100.100"
    ];
  };

  programs.vim.enable = true;

  services = {
    nginx = {
      enable = true;
      streamConfig = /* nginx */ ''
        server {
          listen 80;
          listen [::]:80;

          proxy_connect_timeout 5s;
          proxy_timeout 3m;

          proxy_pass 127.0.0.1:8080;
        }

        server {
          listen 443;
          listen [::]:443;

          proxy_connect_timeout 5s;
          proxy_timeout 3m;

          proxy_pass 127.0.0.1:8443;
        }
      '';
    };

    openssh.settings = {
      ClientAliveInterval = 5;
    };
  };

  time.timeZone = "Europe/Berlin";

  users.users.tunnel = {
    isNormalUser = true;
    shell = "/run/current-system/sw/bin/nologin";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCLy/iTjHILX89/CT/+O6mUVurilUPhD6T+L9Rf/CNx tunnel@xyzbook"
    ];
  };

  system.stateVersion = "25.05";
}
