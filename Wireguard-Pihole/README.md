# Setup a VPN that uses Pihole as DNS

## 1.- Setting a Dynamic DNS Server using afraid.org

Create a Free Account, add a Subdomain.

  Type: A \
  Subdomain: yoursubdomainname \
  Domain: Choose your favourite one \
  Destination: 0.0.0.0 
  
Click on Save 

## 2.- Install ddclient on your Raspberry Pi

```
sudo apt install ddclient
```

Press Enter until the installation is completed.\
Edit the ddclient.conf
```
sudo nano /etc/ddclient.conf
```
Edit ddclient
```
sudo nano /etc/default/ddclient
```

Restart ddclient
```
sudo systemctl restart ddclient
```

Check on afraid.org if your subdomain changed from 0.0.0.0 to your Public IP address or use the below command
```
sudo systemctl status ddclient
```

Make sure systemctl boots with your Raspberry Pi
```
sudo systemctl enable ddclient
```

## 3.- Port Forwarding on your RTR

Devide: Raspberry Pi\
Protocol: UDP\
Aplication: Other/Wireguard\
Port: 51820\
IPV4&IPV6

## 4.- Wireguard + Pihole Containers
We will use the Docker container available at https://docs.linuxserver.io/images/docker-wireguard \
We will force the container to use the Pihole one as DNS. We create a custom network and assign the static IP 172.20.0.7 to Pihole, we assign this netwokr to the Wireguard container on the Docker-Compose file. \
The other settings are the standar ones unless the Dynamic DNS created before. 

## 5.- Connecting to your VPN

Mobile Phone: Download the Wireguard app and scan the QR Code available on the container logs.

Computer: Copy the peer1.cong fil availble at root/wireguard/peer1 to your computer.

Download Wireguard for Windows and import the configuration file.
