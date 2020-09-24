#!/bin/bash

MOON_DB_CONTAINER_ID=$(docker ps | grep "moon-db" | head -n1 | awk '{print $1;}')
MOON_ACCOUNTS_CONTAINER_ID=$(docker ps | grep "moon-accounts" | head -n1 | awk '{print $1;}')

echo ""
echo "==============================================================================="
echo "Starting the moon-db"
echo "==============================================================================="
if [ ! -z "$MOON_DB_CONTAINER_ID" ]; then
	echo ""
	echo "==============================================================================="
	echo "Deleting previous container of the database ..."
	echo "==============================================================================="
	docker rm -f "$MOON_DB_CONTAINER_ID"
fi
docker-compose -f moon-deploy/shared-services.yaml up -d

echo ""
echo "==============================================================================="
echo "Waiting for the database to be initialized"
echo "==============================================================================="
sleep 20s

echo ""
echo "==============================================================================="
echo "Starting the moon-accounts"
echo "==============================================================================="
if [ ! -z "$MOON_ACCOUNTS_CONTAINER_ID" ]; then
	echo ""
	echo "==============================================================================="
	echo "Deleting previous containers of moon-accounts service ..."
	echo "==============================================================================="
	docker rm -f "$MOON_ACCOUNTS_CONTAINER_ID"
fi
docker run --name moon-accounts -p 8081:8081 -d asultandev/moon-accounts:1.0.0