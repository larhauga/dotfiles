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

    for base in $dotdir/*
    do
        # Must be directory, not backup folder, not excluded folders and must contain files
        if [ -d $base ] && [[ ! $base =~ "backup" && ! $base =~ $exclude_folder && ! -z `ls $base/` ]]; then
            # Let init.conf load the other config from the folder.
            # Useful when needing to test for environments
            if [ -f $base/init.conf ]; then
                . $base/init.conf
            else
                # If no init file we load the whole folder
                for import in $base/*
                do
                    # Exlude files defined in envvar
                    if [[ ! $import =~ $exclude ]]; then
                        . $import
                    fi
                done
                unset import
            fi
        # Load file if it is in base folder, and not to be excluded
        elif [ -f $base ] && [[ ! $base =~ $exclude ]]; then
            . $base
        fi
    done
    unset base
    unset exclude
    unset exclude_folder
fi
