#!/usr/bin/env bash

echo "Updating symlink: $1 $2" >> /tmp/docker_symlink.log
if [ ! -z "$(docker ps -qf name=rfcat_sandbox)" ]
then
    docker exec -u 0 rfcat_sandbox ln -sf $1 /dev/$2
fi
