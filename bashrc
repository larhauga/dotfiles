# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
RESET='\e[0m'
DARKGRAY='\e[38;5;239m'
GRAY='\e[38;5;243m'
LGRAY='\e[38;5;250m'
TRUE='\e[1;30;40m'
FALSE='\e[1;30;31m'

# Bash line
RET="$(if [[ $? = 0 ]]; then echo -ne "\[$TRUE\]> \[$RESET"; else echo -ne "\[$FALSE\]> \[$RESET"; fi;)"
PS1="\[$LGRAY\]\A\[$RESET\] \[$DARKGRAY\]\u@\[$RESET\]\[$GRAY\]\h \W\[$RESET\] $RET"

EDITOR=vim

if [ -d $HOME/.config/ ]; then
    if [[ -d $HOME/.config/dotfiles && -f $HOME/.config/dotfiles/envvar ]]; then
        . $HOME/.config/dotfiles/envvar
    else
        if [ ! -f $HOME/.config/.notfirstnoenv ]; then
            echo "Missing environment variables"
            echo "Resolve this by adding config in $HOME/.config/dotfiles/envvar"
            echo "Using default path $HOME/.config/dotfiles"
            touch $HOME/.config/.notfirstnoenv
        fi
        dotdir="$HOME/.config/dotfiles"
    fi

    for file in $dotdir/*
    do
        if [ -f $file ] && [[ ! $file =~ ".swp"|"bashrc"|"tmux.conf" ]]; then
            if [[ `hostname` =~ $jump ]]; then
                if [[ ! $file =~ $workfend|"*.local*" ]]; then
                    . $file
                fi
            elif [[ `hostname` =~ $workdomain ]]; then
                if [[ $file =~ $workfend|"conf$"|"*.local*" ]]; then
                    . $file
                fi
            elif [[ `hostname` =~ $allconf ]]; then
                if [[ $file =~ "conf$"|"*.local*" ]]; then
                    . $file
                fi
            else
                if [[ ! $file =~ $workfend|"tmux"|"bashrc"|"gitignore" ]]; then
                    . $file
                fi
            fi
        fi
    done
fi
