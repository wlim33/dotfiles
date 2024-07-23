#!/bin/sh
CONTAINER_COUNT=$(docker ps -q | wc -l)

if [ $CONTAINER_COUNT -eq "0" ]
then
	exit 1
else
	echo $CONTAINER_COUNT
fi
