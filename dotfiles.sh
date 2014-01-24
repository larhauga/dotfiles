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
        read -p "Use default path? $HOME/.config/dotfiles/ (Y/n): " yn
        case $yn in
            [Nn]* ) read -p "Spesify path: $HOME/" path;
                    config_dir="$HOME/$path";backup_dir="$HOME/$path/backup";
                    sed -i -e "s/dotdir.*//g" envvar;
                    echo "dotdir=\"$config_dir\" #Edited during initial configuration" >> envvar;;
                * ) echo -n "";;
        esac
        echo "Installing dotfiles"
        if [ ! -d $backup_dir ]; then
            mkdir $backup_dir
        fi
        mkdir "$backup_dir/$time"
        cp $HOME/.bashrc "$backup_dir/$time"
        cp $HOME/.tmux.conf "$backup_dir/$time"
        cp $HOME/.gitconfig "$backup_dir/$time"

        read -p "Do you want to update git repo first? (y/N) " yn
        case $yn in
            [Yy]* ) git pull origin master;;
            [Nn]* ) echo "Not updating git repo";;
            * ) echo "Not updating git repo";;
        esac

        rm $HOME/.bashrc
        rm $HOME/.tmux.conf
        rm $HOME/.gitconfig
        ln -s $config_dir/bashrc ~/.bashrc
        ln -s $config_dir/tmux.conf ~/.tmux.conf
        ln -s $config_dir/gitconfig ~/.gitconfig
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

