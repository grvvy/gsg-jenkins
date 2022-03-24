# gsg-jenkins

Tools and instructions for creating and using a build server for testing GSG hardware

# Instructions WIP

```bash
#!/bin/bash
sudo apt-get update
sudo apt-get install git python3-pip
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo pip install --upgrade capablerobot_usbhub
source ~/.profile
sudo cp 20-rfcat.rules 40-ubertooth.rules 52-hackrf.rules 54-greatfet.rules 60-luna.rules /home/<user>/.local/lib/python3.8/site-packages/50-capablerobot-usbhub.rules /etc/udev/rules.d/
sudo udevadm control --reload
sudo udevadm trigger
```

unplug and re-plug both usb hubs

```bash
#!/bin/bash
sudo systemctl edit docker.service
```

add the following lines:

```bash
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2376
```

CTRL+X to exit and save the file

```bash
#!/bin/bash
sudo systemctl daemon-reload
sudo systemctl restart docker.service
```

check that the change happened: (port number 2376)

```bash
#!/bin/bash
sudo netstat -lntp | grep dockerd
```

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
