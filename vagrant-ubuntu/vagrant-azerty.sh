#!/usr/bin/env bash

sed -i -e 's/^exit 0/loadkeys fr ; &/' /etc/rc.local
