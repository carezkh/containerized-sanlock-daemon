#!/bin/execlineb -P

elglob SERVICES /etc/services.d/*

s6-svwait -D ${SERVICES}
