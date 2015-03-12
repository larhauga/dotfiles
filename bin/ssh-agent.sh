#! /bin/bash
start_agent() {
    eval `ssh-agent -t 12h -s | grep -v ^echo | tee ~/.ssh-agent.sh`
    ssh-add
}

if [ -f ~/.ssh-agent.sh ]
then
    source ~/.ssh-agent.sh

    # Server booted / process killed?
    if ! kill -0 $SSH_AGENT_PID 2> /dev/null
    then
        start_agent
    else
        # Keys expired?
        if ! ssh-add -l 2>&1 > /dev/null
        then
            ssh-add
        fi
    fi
else
    # First run ever
    start_agent
fi
