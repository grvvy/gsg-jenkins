#!/bin/bash
groupadd docker
usermod -aG docker $USER
newgrp docker
systemctl enable docker.service
systemctl enable containerd.service
chmod +x /usr/local/bin/docker-compose

