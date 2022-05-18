#!/bin/bash
apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    python3-pip
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update && apt-get install -y \
    containerd.io \
    docker-ce \
    docker-ce-cli \
    openssh-client \
    openssh-server
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
pip install --upgrade capablerobot_usbhub
source ~/.profile
cd udev-rules/
cp 20-rfcat.rules 40-ubertooth.rules 52-hackrf.rules 54-greatfet.rules 60-luna.rules 99-docker_tty.rules /home/gsgadmin/.local/lib/python3.8/site-packages/50-capablerobot-usbhub.rules /etc/udev/rules.d/
udevadm control --reload
udevadm trigger
