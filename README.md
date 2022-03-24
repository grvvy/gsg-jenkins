# gsg-jenkins

Tools and instructions for creating and using a build server for testing GSG hardware

# Instructions WIP

```bash
#!/bin/bash
sudo apt-get install git docker curl python3-pip
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
pip install --upgrade capablerobot_usbhub
source ~/.profile
sudo cp 20-rfcat.rules 40-ubertooth.rules 52-hackrf.rules 54-greatfet.rules 60-luna.rules /home/<user>/.local/lib/python3.8/site-packages/50-capablerobot-usbhub.rules /etc/udev/rules.d/
sudo udevadm control --reload
sudo udevadm trigger
```

unplug and re-plug both usb hubs

```bash
#!/bin/bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo chmod +x /usr/local/bin/docker-compose
```

logout / login
see internal documentation for obtaining .env secrets file and for openvpn setup

```bash
#!/bin/bash
docker-compose build --build-arg DOCKER_GROUP_ID=$(cut -d: -f3 < <(getent group docker)) --no-cache
docker-compose up --no-build
```
