{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        starship
        zile
        # ghostty

        emacs

        emacsPackages.vterm
        emacsPackages.eglot
        emacsPackages.eglot-java
        emacsPackages.agda2-mode

        pandoc

        jetbrains.idea-community

        jdk
        kotlin
        kotlin-language-server

        # TODO: Migrate to home manager, and bring this and my NixOS setup into sync
        # home-manager
      ];

      environment.variables = {
        EDITOR = "zile";
      };

      fonts.packages = with pkgs; [
        iosevka
        noto-fonts
        noto-fonts-color-emoji
      ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#ON-L1912-25
    darwinConfigurations."ON-L1912-25" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
