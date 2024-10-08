#!/bin/sh

iptables -t nat -A POSTROUTING -s 10.10.10.0/255.255.255.0 -j MASQUERADE

exec ocserv -c /etc/ocserv/ocserv.conf -f -d 1