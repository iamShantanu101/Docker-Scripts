#!/bin/sh
#########################################################
# Commiting changes to docker containers                #
#########################################################
container=$(docker ps -n 1 | awk 'NR==2 {print $1}')
image=$(docker ps -n 1 | awk 'NR==2 {print $2}')

echo $image | grep -q '^[0-9a-f]{12}$' && {
	echo "The image appears to be un-named/-tagged: $image. Aborting."
	exit 1
}

cmd="docker commit $container $image"
echo $cmd
$cmd
