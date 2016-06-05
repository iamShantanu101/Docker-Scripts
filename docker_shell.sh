#!/bin/sh
##################################################   
#                                                #
# Default: run shell in last container's image.  #
# TODO: use `--rm` somehow by default?!          #
##################################################

if [ -z $1 ]; then
	container_or_image=$(docker ps -a | awk 'NR == 2 {print $1}')
	echo "Using last container: $container_or_image"
else
	container_or_image=$1
	shift
fi

_i=$(docker inspect $container_or_image | grep '^    "Image": "')
if [ -n "$_i" ]; then
	# Extract image ID.
	_i=$(echo $_i | cut -f4 -d'"')
	
	echo "Running image of docker instance: $_i"
	docker run -i -t --entrypoint=bash "$_i" "$@" --

else
	docker run -i -t --entrypoint=bash "$container_or_image" "$@" --
fi
