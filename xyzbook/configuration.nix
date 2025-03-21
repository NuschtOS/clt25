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

  i18n.defaultLocale = "de_DE.UTF-8";

  networking = {
    hostName = "xyzbook";
    networkmanager.enable = true;
  };

  programs = {
    firefox.enable = true;
    vim.enable = true;
  };

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    openssh.enable = true;
  };

  time.timeZone = "Europe/Berlin";

  users.users."k-ot" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = config.users.users.root.openssh.authorizedKeys.keys;
    packages = with pkgs; [
      tree
    ];
  };

  system.stateVersion = "25.05";
}

