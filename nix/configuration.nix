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
  users.users.nixos = {
    shell = pkgs.zsh;
  };

  # Enable zsh access to basic nix directories in its path
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    sqlite sqlite.dev # Required by some Emacs packages

    zsh
    starship
    zile
    git

    emacs
    pandoc
    mu
    emacsPackages.mu4e

    syncthing

    agda # TODO: consider migrating to emacsPackages.agda-input instead, at least for system-wide installation
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

  # Fonts must be put in the fonts.packages instead of the system packages;
  # see https://nixos.wiki/wiki/Fonts
  fonts.packages = with pkgs; [
    iosevka
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    # symbola # Might look into this later (see Emacs config notes); but it has an unfree license, so not trivial to add.
  ];
  # I will probably need more settings to make Iosevka the default font for installed apps;
  # Emacs handles that itself, so I'm leaving it for now.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
