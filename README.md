dotfiles
========
Configuration for my prefered setup of linux terminals. Supported mainly for Debian/Ubuntu, RHEL/CentOS and MacOS X
* Easy install
* Basic configuration for distributed user config
* Easy to add new configuration (just add new .conf or .local file)
* Contains default bashrc, tmux.conf and usefull aliases

Installation
-------------
    git clone https://github.com/larhauga/dotfiles.git ~/.config/dotfiles
    sh dotfiles.sh install|rollback|update|remove

Configuration
-------------
Add new stuff to the dotfiles by adding or editing the files in the dotfiles directory
By adding a new file named .conf, will it be added when starting a shell (throug autoloading in bashrc)

