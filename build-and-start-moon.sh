#!/bin/bash

MOON_DB_CONTAINER_ID=$(docker ps | grep "moon-db" | head -n1 | awk '{print $1;}')

echo ""
echo "==============================================================================="
echo "Starting the database"
echo "==============================================================================="
if [ ! -z "$MOON_DB_CONTAINER_ID" ]; then
	echo ""
	echo "==============================================================================="
	echo "Deleting previous container of the database ..."
	echo "==============================================================================="
	docker rm -f "$MOON_DB_CONTAINER_ID"
fi
docker-compose -f moon-deploy/shared-services.yaml up -d

sleep 5

./moon-deploy/build-and-start-service.sh moon-accounts &