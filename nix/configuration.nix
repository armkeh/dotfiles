# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # To consider later: Set up a non-"nixos" user for myself
  # users.users.armkeh = {
  #   isNormalUser = true;
  #   home = "/home/armkeh";
  #   extraGroups = [ "wheel" ];
  # };

  environment.systemPackages = with pkgs; [
    gcc
    gnumake

    zsh
    starship
    zile
    git

    iosevka
    emacs
    mu
    emacsPackages.mu4e

    syncthing
  ];

  # Run Emacs as a daemon
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  services.syncthing = {
    enable = true;
    user = "nixos";
    dataDir = "/home/nixos";
    configDir = "/home/nixos/.config/syncthing";
  };

  environment.variables.EDITOR = "zile";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
