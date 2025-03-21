{ modulesPath, ... }:

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
    hostName = "proxy";

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

  time.timeZone = "Europe/Berlin";

  system.stateVersion = "25.05";
}
