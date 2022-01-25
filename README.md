# Getting started with Docker Containers

In this project we will install Docker on a Raspeberry Pi and test it with multiple containers and configurations.

## Install Docker and Docker Compose
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
Add a Non-Root User to the Docker Group
```
sudo usermod -aG docker Pi
```
Test it with a Hello World Container
```
sudo docker run hello-world
```

Install Python and pip3
```
sudo apt-get install libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip
```
Installing Compose using pip
```
sudo pip3 install docker-compose
```
Enable the Docker system service to start your containers on boot
```
sudo systemctl enable docker
```
Upgrade and Uninstall comands
```
sudo apt-get upgrade
sudo apt-get purge docker-ce
```

## Increase the Swap memory
I will recommend to increase your Raspberry Pi Swap capacity to match the RAM memory.

1.- Stop the Swap file
```
sudo dphys-swapfile swapoff
```
2.- Modify the Swap file
```
sudo nano /etc/dphys-swapfile
```
3.- I want to increase it to 1GB
```
CONF_SWAPSIZE=1024
```
4.- Recreate Swap file
```
sudo dphys-swapfile setup
```
5.- Restart de Swapfile and reboot your Raspberry
```
sudo dphys-swapfile swapon
sudo reboot
```
