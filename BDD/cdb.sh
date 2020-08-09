#!/bin/bash
USAGE="Usage:\n\n\tcdb.sh <db-name> [db-user db-pass]"
if [ "$#" -lt 1 ]; then
    echo $USAGE
    exit 1
fi

if [ "$#" -eq 2 ]; then
    echo "ERROR! A password must be provided if you create a user"
    echo $USAGE
    exit 1
fi

CREATEDB="CREATE DATABASE IF NOT EXISTS $1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
CREATEUSER="CREATE USER IF NOT EXISTS $2@localhost IDENTIFIED BY '$3';"
GRANTPRIV="GRANT ALL PRIVILEGES ON $1.* TO $2@localhost; FLUSH PRIVILEGES;"
QUERY=$CREATEDB

if [ "$#" -eq 3 ]; then
    QUERY="$QUERY $CREATEUSER $GRANTPRIV"
fi

mysql -uroot -p -e "$QUERY"
