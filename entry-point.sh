#!/usr/bin/env bash

pg_ctl -D /var/lib/postgresql/data -l /var/lib/postgresql/pglog.log start
tail -f /var/lib/postgresql/pglog.log
