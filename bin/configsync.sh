#! /bin/bash
# Fast syncing configuration to other machines over ssh
# Usefull for servers without direct internet connection

if [ -z "$1" ]; then
    echo "Usage: configsync.sh <host.domain.net>"
else
    SERVER=$1
    scp $HOME/.bashrc $SERVER:$HOME/.
    scp -r $dotdir/* $SERVER:$dotdir/.
    echo "Synced config"
fi
