#! /bin/bash

####################
# Installation of dotfiles
# sh dotfiles.sh install|rollback
# Lars Haugan
####################

help(){
    echo "Usage $0 install|rollback|remove"
    echo "Dotfiles script for installing, reverting or uninstalling the scripts"
}

time=`date +"%Y-%m-%d-%H%M"`
config_dir="~/.config"
backup_dir="$HOME/.config/backup"

if [ $# -eq 1 ]; then
    if [ "$1" = "install" ]; then
        echo "Installing dotfiles"
        if [ ! -d $backup_dir ]; then
            mkdir $backup_dir
        fi
        mkdir "$backup_dir/$time"
        cp ~/.bashrc "$backup_dir/$time"
        cp ~/.tmux.conf "$backup_dir/$time"

        rm ~/.bashrc
        rm ~/.tmux.conf
        ln -s ~/.config/bashrc ~/.bashrc
        ln -s ~/.config/tmux.conf ~/.tmux.conf

    elif [ "$1" = "rollback" ]; then
        last_backup=`ls -t $backup_dir/ | head -1`
        echo "Rolling back to last install, $last_backup"
        rm ~/.bashrc
        rm ~/.tmux.conf
        cp $last_backup/* ~/.

    elif [ "$1" = "remove" ]; then
        echo "Removing configuration and reverting to latest config"
        first_backup=`ls -t $backup_dir/ | tail -1`
        rm ~/.bashrc
        rm ~/.tmux.conf
        cp $first_backup/* ~/.
    else
        help
    fi
else
    help
fi

