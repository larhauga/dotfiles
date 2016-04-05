# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -d $HOME/.config/ ]; then
    if [[ -d $HOME/.config/dotfiles && -f $HOME/.config/dotfiles/envvar ]]; then
        . $HOME/.config/dotfiles/envvar
    else
        dotdir="$HOME/.config/dotfiles"
    fi

    for base in $dotdir/*; do
        # Must be directory, not backup folder, not excluded folders and must contain files
        if [ -d $base ] && [[ ! $base =~ "backup" && ! $base =~ $exclude_folder && ! -z `ls $base/` ]]; then
            # sub init.conf to load sub scripts
            if [ -f $base/init.conf ]; then
                . $base/init.conf
            else
                for import in $base/*; do
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

# Putt other add-hoc stuff here .config/dotfiles/misc/exports.conf
