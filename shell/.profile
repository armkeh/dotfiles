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
# I had this setting for a Debian machine setup with Nix as a package manager.
# It doesn't work for NixOS, though, and I'm not certain if it is out of date for the package manager as well.
# if [ -d "$HOME/.nix-profile" ] ; then
#   source ~/.nix-profile/etc/profile.d/nix.sh
# fi

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
  export PATH="$PATH:$HOME/go/bin"
fi

if [ -d "$HOME/.guix-profile/lib/locale" ] ; then
  export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale
fi

if command -v gls 2>&1 >/dev/null; then
  ls() {
    if command -v gls 2>&1 >/dev/null; then
      gls "${@}"
    else
       ls "${@}"
    fi
  }
fi

# Disable some legacy docker commands
export DOCKER_HIDE_LEGACY_COMMANDS=true

# Check mu installed and info returns error (indicates not initialized)
if command -v mu >/dev/null && ! mu info >/dev/null 2>/dev/null; then
  echo "mu installed but `mu info` returns error; trying to initialize mu"
  mu init --maildir="~/.mail/gmail" --my-address="markparmstrong@gmail.com"
  echo "`mu index` will be handled by mu4e if no action taken"
# else
#   echo "mu already running"
fi

NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

if [ -f ~/.profile_local ] ; then
  source ~/.profile_local
fi

if [ -f ~/.profile_private ] ; then
  source ~/.profile_private
fi
