#!/bin/bash

HOME='/root'

cp $HOME/sample/playbook.yml $HOME/
echo "[target]" > $HOME/hosts
echo "$WEB_PORT_80_TCP_ADDR" >> $HOME/hosts

ssh-keyscan $WEB_PORT_80_TCP_ADDR > $HOME/.ssh/known_hosts  2> /dev/null
yes root | ssh-copy-id $WEB_PORT_80_TCP_ADDR
