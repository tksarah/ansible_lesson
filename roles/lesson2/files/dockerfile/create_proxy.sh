#!/bin/bash

HOST="HOSTADDR"
FILE="myproxy"

cat << EOS > $FILE
server {
    listen 80;
    server_name _;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
EOS

for USER in `cat userlist`
	do

	CPORT=`/bin/docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' ${USER}_l2_target | gawk '{ print $3 }'`
	#CIP=`/bin/docker inspect --format '{{.NetworkSettings.IPAddress}}' "${USER}_l2_target"`

	echo "    location /${USER}_wordpress/ {" >> $FILE
	echo "        proxy_pass http://$HOST:$CPORT/wordpress/;" >> $FILE
	echo "    }" >> $FILE
	done

echo "}" >> $FILE
