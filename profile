# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi



# My settings

# Haskell and OCaml binaries
if [ -d "/opt/ghc/bin" ] ; then
    PATH="$PATH:/opt/ghc/bin"
fi
if [ -d "$HOME/.cabal/bin" ] ; then
    PATH="$PATH:$HOME/.cabal/bin"
fi
if [ -d "$HOME/.opam/system/bin" ] ; then
    PATH="$PATH:$HOME/.opam/system/bin"
fi

if [ -d "/opt/ghc/bin" ] ; then
    PATH="$PATH:/opt/ghc/bin"
fi

# Nodejs (added manually during setup thereof)
# Must be updated when changing versions
if [ -d "/usr/local/lib/nodejs/node-v13.8.0-linux-x64/bin" ] ; then
    VERSION=v13.8.0
    DISTRO=linux-x64
    PATH="$PATH:/usr/local/lib/nodejs/node-v13.8.0-linux-x64/bin"
fi
