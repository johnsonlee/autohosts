#!/bin/bash

URL_OLD_HOSTS=/etc/hosts
URL_NEW_HOSTS=http://googlehosts-hostsfiles.stor.sinaapp.com/hosts

if [ `grep "http://www.findspace.name" $URL_OLD_HOSTS | wc -l` -gt 0 ]; then
    UPDATE_TIME=$(grep -n "^#+UPDATE_TIME" $URL_OLD_HOSTS | awk -F: '{print $1}')
    diff -Naur <(tail -n +$UPDATE_TIME $URL_OLD_HOSTS) <(curl -sL $URL_NEW_HOSTS) | patch -p1 $URL_OLD_HOSTS
else
    curl -sL $URL_NEW_HOSTS >> $URL_OLD_HOSTS
fi
