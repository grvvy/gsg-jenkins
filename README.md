# gsg-jenkins

Tools and instructions for creating and using a build server for testing GSG hardware
https://www.yougetsignal.com/tools/open-ports/?msclkid=81d1d4d0c10211ec81b7ab758d2f62f7

## Prerequisites
1. Open a terminal and install git by running `sudo apt-get install git`
2. Clone this repository by running `git clone https://github.com/grvvy/gsg-jenkins.git`
3. Change directory into the repo directory with `cd gsg-jenkins/`
4. Run the prerequisite installation script with `sudo startup/prereq-installations.sh`
```bash
#!/bin/bash
apt-get update
apt-get install git python3-pip
apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io openssh-server openssh-client
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
pip install --upgrade capablerobot_usbhub
source ~/.profile
cd udev-rules/
cp 20-rfcat.rules 40-ubertooth.rules 52-hackrf.rules 54-greatfet.rules 60-luna.rules 99-docker_tty.rules /home/gsgadmin/.local/lib/python3.8/site-packages/50-capablerobot-usbhub.rules /etc/udev/rules.d/
udevadm control --reload
udevadm trigger
```

## To disable suspend on laptop lid close, open logind.conf in your terminal:
```bash
sudo nano /etc/systemd/logind.conf
```
and make sure the following option is not commented out and is set to ignore: `HandleLidSwitch=ignore`

## Docker setup
* Unplug and re-plug both usb hubs, then run `sudo startup/docker-setup.sh`

```bash
#!/bin/bash
groupadd docker
usermod -aG docker $USER
newgrp docker
systemctl enable docker.service
systemctl enable containerd.service
chmod +x /usr/local/bin/docker-compose
```
2. Logout / login
3. See internal documentation for obtaining .env secrets file and for openvpn setup

## Starting the Jenkins server
* To start up the Jenkins instance, run `startup/start-jenkins.sh`
```bash
#!/bin/bash
docker-compose build --build-arg DOCKER_GROUP_ID=$(cut -d: -f3 < <(getent group docker))
docker-compose up --no-build --detach
docker exec -u root jenkins-controller sh -c "dockerd > /var/log/dockerd.log 2>&1 &"
```
