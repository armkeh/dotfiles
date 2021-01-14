# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh-histfile
HISTSIZE=1000
SAVEHIST=99999
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/markparmstrong/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Beginning of my customisations

# Set the prompt -----------------------------------------------------
# See http://zsh.sourceforge.net/Intro/intro_14.html

# Note the wrapping of unprinted characters in %{ %} delimiters

# Colours
Connector_colour="%{%F{046}%}" # Light green
User_colour="%{%F{196}%}"      # Light red
Host_colour="%{%F{201}%}"      # Light purple
Date_colour="%{%F{214}%}"      # Orangey yellow
Time_colour="%{%F{226}%}"      # Light yellow
PWD_colour="%{%F{51}%}"        # Cyan
Clear_colour="%{%f%}"

# Unicode box drawing symbols to connect everything.
Prompt_TopRight="$Connector_colour┌─["
Prompt_Break="$Connector_colour]──["
Prompt_EndLine="$Connector_colour]"
Prompt_Vertical="$Connector_colour│"

# %f undoes colour setting
Prompt_Prompt="$Connector_colour└─►$Clear_colour $ "

# Note that %D{s} formats s using strftime
Prompt_UserHost="$User_colour%n$Host_colour@%M"
Prompt_Date="$Date_colour%D{%a %b %d}"
Prompt_Time="$Time_colour%D{%T}"

# A shortened PWD, code taken from
# https://unix.stackexchange.com/questions/273529/shorten-path-in-zsh-prompt/273567#273567
Prompt_PWD="$PWD_colour%(5~|%-1~/…/%3~|%4~)"

Prompt_L1="$Prompt_TopRight$Prompt_UserHost$Prompt_Break$Prompt_Date$Prompt_Break$Prompt_Time$Prompt_EndLine"
Prompt_L2="$Prompt_Vertical $Prompt_PWD"
Prompt_L3="$Prompt_Prompt"

# This is supposedly a portable solution
Newline=$'\n'

PROMPT="${Newline}$Prompt_L1${Newline}$Prompt_L2${Newline}$Prompt_L3"

# Reset the prompt regularly to keep the clock current
# If problems occur with refreshing or scroll position jumping, look here.
# Maybe reference https://github.com/sorin-ionescu/prezto/issues/1512
#TMOUT=1
#TRAPALRM() {
#    zle reset-prompt
#}

# END Set the prompt -------------------------------------------------

# Force colourised ls output
alias ls='ls --color=auto'
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/markparmstrong/.sdkman"
[[ -s "/home/markparmstrong/.sdkman/bin/sdkman-init.sh" ]] && source "/home/markparmstrong/.sdkman/bin/sdkman-init.sh"
