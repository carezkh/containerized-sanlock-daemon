#!/bin/sh

# TODO: don't use '-D' for debug mode.
/usr/sbin/wdmd -D &
/usr/sbin/sanlock daemon -D -U 0 -G 0 -e `cat /etc/hostname` &
sleep infinity
