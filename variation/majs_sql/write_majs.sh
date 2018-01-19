#! /bin/sh
. ../inc/config.sh
if [ "$DBNAME" = "" ]; then
    echo "ERR: DBNAME non défini dans inc/config.sh";
    exit;
fi
if [ "$DBPASS" = "" ]; then
    echo "ERR: DBPASS non défini dans inc/config.sh";
    exit;
fi
if [ "$DBUSER" = "" ]; then
    echo "ERR: DBUSER non défini dans inc/config.sh";
    exit;
fi

if [ "$DBHOST" = "" ]; then
    DBHOST = "localhost";
fi
(echo "BEGIN TRANSACTION;"; cat *.sql; echo 'COMMIT;') |  PGPASSWORD=$DBPASS PGOPTIONS="--client-min-messages=warning" psql -q -h $DBHOST -U $DBUSER $DBNAME
