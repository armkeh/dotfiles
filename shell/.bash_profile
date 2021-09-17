if [ -f ~/.profile ]; then
  source ~/.profile
fi

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"
