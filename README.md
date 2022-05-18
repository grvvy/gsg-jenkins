# gsg-jenkins

Tools and instructions for creating and using a build server for testing GSG hardware

## Prerequisites
1. Open a terminal and install git by running `sudo apt-get install git`
2. Clone this repository by running `git clone https://github.com/grvvy/gsg-jenkins.git`
3. Change directory into the repo directory with `cd gsg-jenkins/`
4. Run the prerequisite installation script with `sudo startup/prereq-installations.sh`
5. Make sure all DFU capable devices are wired to boot from DFU mode (H1, GF1, U1, YS1)
6. Plug GF1, H1, LUNA, and U1 into ports 1-4 respectively on Hub 1 (Hub Key D9D1)
7. Plug YS1 into port 1 on Hub 2 (Hub Key 624C)
8. (Optional) To disable suspend on laptop lid close, open logind.conf in your terminal: `sudo nano /etc/systemd/logind.conf` and make sure the following option is *not* commented out and *is* set to ignore like so: `HandleLidSwitch=ignore`

## Docker setup
1. Unplug and re-plug both Capable Robot usb hubs, then run `sudo startup/docker-setup.sh`
2. Logout / login
3. See internal documentation for obtaining .env secrets file and for openvpn setup

## Starting the Jenkins server
* To start up the Jenkins instance, run `startup/start-jenkins.sh`
