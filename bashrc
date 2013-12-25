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
RET='$(if [[ $? = 0 ]]; then echo -ne "\[$TRUE\]> \[$RESET"; else echo -ne "\[$FALSE\]> \[$RESET"; fi;)'
PS1="\[$LGRAY\]\A\[$RESET\] \[$DARKGRAY\]\u@\[$RESET\]\[$GRAY\]\h \W\[$RESET\] $RET"

EDITOR=vim

if [ -d ~/.config/ ]; then
    if [ -f ~/.config/envvar ]; then
        . ~/.config/envvar
    else
        if [ ! -f ~/.config/.notfirstnoenv ]; then
            echo "Missing environment variables"
            echo "Resolve this by adding config in ~/.config/envvar"
            touch ~/.config/.notfirstnoenv
        fi
    fi

    for file in ~/.config/.*
    do
        if [ -f $file ] && [[ ! $file =~ ".swp"|"bashrc"|"tmux.conf" ]]; then
            if [[ `hostname` =~ $jump ]]; then
                if [[ ! $file =~ $workfend ]]; then
                    . $file
                fi
            elif [[ `hostname` =~ $workdomain ]]; then
                if [[ $file =~ $workfend|"conf$" ]]; then
                    . $file
                fi
            else
                if [[ ! $file =~ $workfend|"tmux"|"bashrc" ]]; then
                    . $file
                fi
            fi

        fi
    done
fi
