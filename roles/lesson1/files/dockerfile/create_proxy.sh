#!/bin/bash

HOST="HOSTADDR"
OUTFILE="/tmp/dockerfile/myproxy"
INFILE="/tmp/dockerfile/userlist"

cat << EOS > $OUTFILE
server {
    listen 80;
    server_name _;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
EOS

for USER in `cat $INFILE`
        do

        CPORT=`/bin/docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' ${USER}_l1_target | gawk '{ print $3 }'`
        #CIP=`/bin/docker inspect --format '{{.NetworkSettings.IPAddress}}' "${USER}_l1_target"`

        echo "    location /${USER}_wordpress/ {" >> $OUTFILE
        echo "        proxy_pass http://$HOST:$CPORT/wordpress/;" >> $OUTFILE
        echo "    }" >> $OUTFILE
        done

echo "}" >> $OUTFILE
