#!/bin/sh

echo "Exécution du docker-entrypoint"

if [ "$NODE_ENV" = "development" ]
then
    npm install
fi 

exec "$@"
