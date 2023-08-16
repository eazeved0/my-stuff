#!/bin/bash

DIR=$HOME/local/bin

mkdir -p $DIR >/dev/null 2>&1

curl -Lo $DIR/docker-ps http://eazevedo.cloud/dops
curl -Lo $DIR/docker-shell https://eazevedo.cloud/docker-shell
curl -Lo $DIR/docker-logs https://eazevedo.cloud/docker-logs

chmod +x $DIR/docker*

echo "alias dops='$DIR/docker-ps'" >> $HOME/.bashrc
echo "alias dosh='$DIR/docker-shell'" >> $HOME/.bashrc
echo "alias dologs='$DIR/docker-logs'" >> $HOME/.bashrc

source $HOME/.bashrc
