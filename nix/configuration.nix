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

    # Enable home manager; see https://nix-community.github.io/home-manager/
    <home-manager/nixos>
  ];

  wsl.enable = true;
  wsl.defaultUser = "armkeh";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  home-manager = {
    users = {
      armkeh = import /home/armkeh/home.nix;
    };
  };

  # Login shell must be set at system level
  programs.zsh.enable = true;
  users.users.armkeh.shell = pkgs.zsh;

  # TODO: move this service to home-manager config once it's better supported there;
  #       see https://github.com/nix-community/home-manager/issues/4049
  services.syncthing = {
    enable = true;
    user = "armkeh";
    dataDir = "/home/armkeh";
    configDir = "/home/armkeh/.config/syncthing";
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
