# gsg-jenkins

Tools and instructions for creating and using a build server for testing GSG hardware
https://www.yougetsignal.com/tools/open-ports/?msclkid=81d1d4d0c10211ec81b7ab758d2f62f7
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
sudo apt-get install docker-ce docker-ce-cli containerd.io openssh-server openssh-client
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo pip install --upgrade capablerobot_usbhub
source ~/.profile
cd udev-rules/
sudo cp 20-rfcat.rules 40-ubertooth.rules 52-hackrf.rules 54-greatfet.rules 60-luna.rules 99-docker_tty.rules /home/<user>/.local/lib/python3.8/site-packages/50-capablerobot-usbhub.rules /etc/udev/rules.d/
sudo udevadm control --reload
sudo udevadm trigger
```

# To disable suspend on laptop lid close, open logind.conf in your terminal:
```bash
sudo nano /etc/systemd/logind.conf
```
and make sure the following option is not commented out and is set to ignore: `HandleLidSwitch=ignore`

Next, unplug and re-plug both usb hubs, then run:

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
docker-compose build --build-arg DOCKER_GROUP_ID=$(cut -d: -f3 < <(getent group docker))
docker-compose up --no-build --detach
docker exec -u root jenkins-controller sh -c "dockerd > /var/log/dockerd.log 2>&1 &"
```
