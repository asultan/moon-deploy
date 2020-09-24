#!/bin/bash

if [ -z "$1" ]
  then
    echo ""
    echo "RUNTIME ERROR >> You did not specify the service to deploy"
    echo ""
    echo "USAGE:"
    echo "  build-and-deploy.sh <service-name>"
    echo ""
   exit
fi

SERVICE_NAME_LOWER_CASE=$1
SERVICE_NAME_UPPER_CASE=${SERVICE_NAME_LOWER_CASE^^}

CONTAINER_ID=$(docker ps | grep "$SERVICE_NAME_LOWER_CASE" | head -n1 | awk '{print $1;}')

echo ""
echo "==============================================================================="
echo "Building the $SERVICE_NAME_UPPER_CASE service ..."
echo "==============================================================================="
./moon-deploy/build-service.sh "$SERVICE_NAME_LOWER_CASE"

echo ""
echo "==============================================================================="
echo "Deleting previous containers of $SERVICE_NAME_UPPER_CASE service ..."
echo "==============================================================================="
if [ ! -z "$CONTAINER_ID" ]; then
	docker rm -f "$CONTAINER_ID"
fi

echo ""
echo "==============================================================================="
echo "Starting the $SERVICE_NAME_UPPER_CASE service ..."
echo "==============================================================================="
docker run --name "$SERVICE_NAME_LOWER_CASE" -p 8081:8081 -d asultandev/"$SERVICE_NAME_LOWER_CASE":1.0.0