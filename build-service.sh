#!/bin/bash

SERVICE_NAME_LOWER_CASE=$1
SERVICE_NAME_UPPER_CASE=${SERVICE_NAME_LOWER_CASE^^}

echo ""
echo "==============================================================================="
echo "Navigating to $SERVICE_NAME_UPPER_CASE repository folder"
echo "==============================================================================="
cd ./"$SERVICE_NAME_LOWER_CASE"

echo ""
echo "==============================================================================="
echo "Pulling latest changes for the $SERVICE_NAME_UPPER_CASE repository"
echo "==============================================================================="
git pull

echo ""
echo "==============================================================================="
echo "Building the $SERVICE_NAME_UPPER_CASE service, create docker image and push it to hub.docker.com ..."
echo "==============================================================================="
echo ""
mvn clean compile jib:build