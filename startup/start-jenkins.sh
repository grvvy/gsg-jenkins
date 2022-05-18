#!/bin/bash
docker-compose build --build-arg DOCKER_GROUP_ID=$(cut -d: -f3 < <(getent group docker))
docker-compose up --no-build --detach
docker exec -u root jenkins-controller sh -c "dockerd > /var/log/dockerd.log 2>&1 &"
