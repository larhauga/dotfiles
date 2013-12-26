#! /bin/bash

####################
# Installation of dotfiles
# sh dotfiles.sh install|rollback
# Lars Haugan
####################

help(){
    echo "Usage $0 install|rollback|update|remove"
    echo "Dotfiles script for installing, reverting or uninstalling the scripts"
}

time=`date +"%Y-%m-%d-%H%M"`
config_dir="$HOME/.config/dotfiles"
backup_dir="$HOME/.config/dotfiles/backup"

if [ $# -eq 1 ]; then
    if [ "$1" = "install" ]; then
        echo "Installing dotfiles"
        if [ ! -d $backup_dir ]; then
            mkdir $backup_dir
        fi
        mkdir "$backup_dir/$time"
        cp $HOME/.bashrc "$backup_dir/$time"
        cp $HOME/.tmux.conf "$backup_dir/$time"

        rm $HOME/.bashrc
        rm $HOME/.tmux.conf
        ln -s $config_dir/bashrc ~/.bashrc
        ln -s $config_dir/tmux.conf ~/.tmux.conf
        echo "New configuration installed"
    elif [ "$1" = "rollback" ]; then
        last_backup=`ls -t $backup_dir/ | head -1`
        echo "Rolling back to last install, $last_backup"
        rm $HOME/.bashrc
        rm $HOME/.tmux.conf
        cp $last_backup/* $HOME/.
        echo "Config has been rolled back"
    elif [ "$1" = "remove" ]; then
        echo "Removing configuration and reverting to latest config"
        first_backup=`ls -t $backup_dir/ | tail -1`
        rm $HOME/.bashrc
        rm $HOME/.tmux.conf
        cp $first_backup/* $HOME/.
        echo "Config has been removed"
    elif [ "$1" = "update" ]; then
        if [ ! -d $backup_dir ]; then
            mkdir $backup_dir
        fi
        mkdir "$backup_dir/$time"
        cp $HOME/.bashrc "$backup_dir/$time"
        cp $HOME/.tmux.conf "$backup_dir/$time"
        git pull origin master
    else
        help
    fi
else
    help
fi

