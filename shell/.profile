# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# Guix
if [ -d "$HOME/.guix-profile" ] ; then
  # This setup based on that done by the Guix System
  for profile in "$HOME/.guix-profile" "$HOME/.config/guix/current"
  do
    if [ -f "$profile/etc/profile" ]
    then
      # Load the user profile's settings.
      GUIX_PROFILE="$profile" ; \
        . "$profile/etc/profile"
    else
      # At least define this one so that basic things just work
      # when the user installs their first package.
      export PATH="$profile/bin:$PATH"
    fi
  done
fi

# Nix
if [ -d "$HOME/.nix-profile" ] ; then
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/local/bin" ] ; then
    export PATH="$HOME/local/bin:$PATH"
fi
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Tool install directories

# Haskell tools
if [ -d "/opt/ghc/bin" ] ; then
    export PATH="$PATH:/opt/ghc/bin"
fi
if [ -d "$HOME/.cabal/bin" ] ; then
    export PATH="$PATH:$HOME/.cabal/bin"
fi

# OCaml package manager
if [ -d "$HOME/.opam/system/bin" ] ; then
    export PATH="$PATH:$HOME/.opam/system/bin"
fi

# Rust's package manager
if [ -d "$HOME/.cargo/bin" ] ; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi

# The Go path used by Golang by default
if [ -d "$HOME/go/bin" ] ; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi

# Disable some legacy docker commands
export DOCKER_HIDE_LEGACY_COMMANDS=true
