dotfiles
========
Configuration for my prefered setup of linux terminals. ~~Supported~~ Developed and updated mainly for Debian/Ubuntu, RHEL/CentOS and MacOS X
* Easy install
* Basic configuration for distributed user config
* Easy to add new configuration (just add new file in the dotfiles folder)
* Contains default bashrc, tmux.conf and usefull aliases and exports

Installation
-------------
    git clone https://github.com/larhauga/dotfiles.git ~/.config/dotfiles
    sh dotfiles.sh install|rollback|update|remove

Configuration
-------------
This dotfiles directory is designed to support further development and continual configuration, and is meant as a small and lightweight framework for configuration of terminals.
With this it is intended that there should be done configuration.
If there is need for new configuration, just add a new *.local* file, and it will not be overwritten by any new updates.

### The default directories 
By default there several sub-directories which will be searched through by bashrc.
If there are any files in these directories, which are not excluded (view envvar), they are added.
To allow spesific where to load the directory, there is just the matter of adding a init.conf file (this will always be read first)

#### alias
This directory contains all the alases which will be added. This directory will after a while contain many aliases separated into files.
A *file* represents a *set of aliases*, where tmux aliases is an example.

#### bin
This directory contains a init.conf which will add the bin directory to **$PATH**.

#### osx
The OSX directory also contains and init.conf, which only loads the directory if it is running on a Darwin machine.
Here there are posibilities to overwrite aliases, such as ls --color which does not work in termnial.app

#### misc
All the other files which should be loaded.

#### theme
Edit the init.conf variable theme to the name of the file of the theme to be loaded.

### All the other files
By default, there are files described in envvar which are excluded from beeing loaded.
This means that if there are added new files to the dotfile directory, they will be added.
This is done by the more universal "." or dot notation `. .bashrc` which in comparison to source does not work all over (though still most places; I have not done any good research on this).
