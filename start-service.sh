#!/bin/bash

if [ -z "$1" ]
  then
    echo ""
    echo "RUNTIME ERROR >> You did not specify the service to deploy"
    echo ""
    echo "USAGE:"
    echo "  build-and-deploy.sh <service-name> <port>"
    echo ""
   exit
fi

SERVICE_NAME=$1
PORT=$2

CONTAINER_ID=$(docker ps | grep "$SERVICE_NAME" | head -n1 | awk '{print $1;}')
if [ ! -z "$CONTAINER_ID" ]; then
	echo ""
	echo "==============================================================================="
	echo "Deleting previous containers of $SERVICE_NAME service ..."
	echo "==============================================================================="
	docker rm -f "$CONTAINER_ID"
fi

echo ""
echo "==============================================================================="
echo "Starting the $SERVICE_NAME service ..."
echo "==============================================================================="
docker run --name "$SERVICE_NAME" -p $PORT:$PORT -d asultandev/"$SERVICE_NAME":1.0.0