{ config, pkgs, services, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "armkeh";
  home.homeDirectory = "/home/armkeh";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git
    gcc
    gnumake
    sqlite sqlite.dev   # Required by some Emacs packages

    zsh
    starship
    zile

    emacs

    # Emacs packages; currently limited to those which would require compilation or additional installation
    emacsPackages.mu4e
    emacsPackages.vterm
    emacsPackages.eglot
    emacsPackages.eglot-java
    emacsPackages.agda2-mode # Includes agda-input, which I use fairly generally

    pandoc
    mu
    emacsPackages.mu4e

    syncthing

    # agda

    iosevka
    noto-fonts

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    ".aliases".source      = ../shell/.aliases;
    ".bash_profile".source = ../shell/.bash_profile;
    ".bashrc".source       = ../shell/.bashrc;
    ".profile".source      = ../shell/.profile;
    ".zprofile".source     = ../shell/.zprofile;
    ".zshrc".source        = ../shell/.zshrc;
    ".config/starship.toml".source = ../shell/starship.toml;

    ".config/emacs/emacs-init.org".source = ../emacs/emacs-init.org;
    # TODO: add the barebones init.el as plaintext here; then home-manager will prevent changes!

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/armkeh/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "zile";   # If I want Emacs, I will open it from Emacs. From the terminal, use the simpler Zile.
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
