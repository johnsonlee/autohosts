#!/bin/bash

URL_OLD_HOSTS=/etc/hosts
URL_NEW_HOSTS=http://googleips-google.stor.sinaapp.com/hosts

if [ `grep "http://www.findspace.name" $URL_OLD_HOSTS | wc -l` -lt 0 ]; then
    curl -sL $URL_NEW_HOSTS >> $URL_OLD_HOSTS
else
    BEGIN=$(grep -n "^#+BEGIN" $URL_OLD_HOSTS | awk -F: '{print $1}')
    diff -Naur <(tail -n +$BEGIN $URL_OLD_HOSTS) <(curl -sL $URL_NEW_HOSTS) | patch -p1 /etc/hosts
fi
