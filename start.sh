#!/usr/bin/env bash
service salt-minion start
service ssh start
tail -f /var/log/salt/salt-minion.log