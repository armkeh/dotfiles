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
      # Enable non-free packages
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        git

        gcc
        cmake
        # gnumake
        # xcbuild # Xcode-compatible build tools
        glibtool

        coreutils-prefixed # GNU core utilities, prefixed by 'g'; especially useful on MacOS where some utils have different behaviour (such as ls not supporting all flags)

        # Since docker-desktop is not available (yet; see https://github.com/NixOS/nixpkgs/issues/228972),
        # I have installed Docker (Desktop) manually.
        # docker

        starship
        zile
        # ghostty

        emacs
        # emacs-macport # Emacs 29 is marked insecure; wait for update

        # # Disabled Emacs and its packages until https://github.com/NixOS/nixpkgs/issues/395169 is resolved.
        # emacsPackages.vterm
        # # libvterm # Not supported on MacOS
        # emacsPackages.eglot
        # emacsPackages.eglot-java
        # emacsPackages.agda2-mode

        pandoc

        jetbrains.idea-community

        nixd # Nix language server

        jdk21 # See system.activationScripts for linking into /Library/Java/JavaVirtualMachines/; for the moment, stick to fixed versions
        maven
        gradle
        kotlin
        kotlin-language-server
        kotlin-interactive-shell

        circleci-cli

        postman

        zoom-us

        # TODO: Migrate to home manager, and bring this and my NixOS setup into sync
        # home-manager

        vlc-bin # Pre-compiled VLC binary for MacOS; vlc package is not supported on MacOS
      ];

      # # Enable nix-darwin control of Homebrew taps, formulae and casks, and by extension, Mac App Store apps and Docker containers
      # # MUST INSTALL HOMEBREW (manually) BEFORE LOADING THIS FLAKE
      # # Disabled at the moment as my DisplayLink dock is not functioning anyway
      homebrew.enable = true;

      homebrew.casks = [
        # "displaylink"
        # "ddpm" # Dell Display and Peripheral Manager

        "emacs" # Backup install in case of issues with Nix package, which I've encountered after system updates
      ];

      environment.variables = {
        EDITOR = "zile";
      };

      fonts.packages = with pkgs; [
        iosevka
        noto-fonts
        noto-fonts-color-emoji
        emacs-all-the-icons-fonts
      ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Link the JDK(s) to /Library/Java/JavaVirtualMachines/
      #
      # In an ideal world, this would be handled by programs.java config;
      # but it seems that is not present in nix darwin.
      #
      # The below automatically creates symlinks for us, but will not clean them up,
      # so possibly leaves artifacts.
      # And it also relies upon a fixed JDK version.
      #
      # See https://samasaur1.github.io/blog/jdks-on-nix-darwin.
      system.activationScripts.extraActivation.text = ''
        ln -sf "${pkgs.jdk21}/zulu-21.jdk" "/Library/Java/JavaVirtualMachines/"
      '';

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
