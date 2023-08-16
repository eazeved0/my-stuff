#!/bin/bash

DIR=$HOME/local/bin

mkdir -p $DIR >/dev/null 2>&1

curl -# -Lo $DIR/docker-ps http://eazevedo.cloud/dops
curl -# -Lo $DIR/docker-shell https://eazevedo.cloud/docker-shell
curl -# -Lo $DIR/docker-logs https://eazevedo.cloud/docker-logs

chmod +x $DIR/docker*

echo "alias dops='$DIR/docker-ps'" >> $HOME/.bashrc
echo "alias dosh='$DIR/docker-shell'" >> $HOME/.bashrc
echo "alias dolog='$DIR/docker-logs'" >> $HOME/.bashrc

source $HOME/.bashrc

red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'

clear
echo -e "${red} ######### Docker Shortcuts #########\n"

echo -e "${blue}Use dops to have a better view of docker ps:"
echo -e "${green} \$ dops\n"
echo -e "${blue}Use dolog to interactively see docker logs (use -f to watch logs):"
echo -e "${green} \$ dolog (or dolog -f)\n"
echo -e "${blue}Use dosh to interactively have access to docker terminal:"
echo -e "${green} \$ dosh\n"

echo -e "${red} !! Update your current bash session to use immediately:"
echo -e "${green}$ source $HOME/.bashrc "
