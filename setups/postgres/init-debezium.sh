#!/bin/sh
set -e
export DEBEZIUM_PASSWORD="${DEBEZIUM_PASSWORD:-debezium_pass}"
sed "s/\\${DEBEZIUM_PASSWORD}/$DEBEZIUM_PASSWORD/g" /docker-entrypoint-initdb.d/10-global.sql.template > /docker-entrypoint-initdb.d/10-global.sql
