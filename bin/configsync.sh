#! /bin/bash

configsync(){
    if [ -z "$1" ]; then
        echo "Usage: configsync.sh <host.domain.net>"
    else
        SERVER=$1
        scp $HOME/.bashrc $SERVER:$HOME/.
        scp -r $dotdir/. $SERVER:$dotdir/.
        echo "Synced config"
    fi
}
