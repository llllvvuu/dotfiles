# usage: `source start-ssh-agent.sh`
ssh-agent | sed 's/^echo/#echo/' > $HOME/.ssh/environment
. $HOME/.ssh/environment
