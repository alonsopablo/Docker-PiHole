# Install PiHole and assign a Static IP on a mcvlan

## Create a macvlan network for your Containers. Named docker_net
We will reserve this new network range on our RTR DHCP 192.168.0.192-224. This way we have a subnet of 32 available addresses to deploy our containers. The IP 192.168.1.224 will be reserved to connect this macvlan to the localhost.

```
 docker network create -d macvlan -o parent=eth0 \
  --subnet=192.168.0.0/24 \
  --gateway=192.168.0.1 \
  --ip-range=192.168.0.192/27 \
  --aux-address "host=192.168.0.224" \
  docker_net
```

Test deploying a nginx on that mcvlan
```
docker run --net=docker_net -dit --name nginx-test-01 --ip=192.168.0.211 nginx:alpine nginx-debug -g 'daemon off;'
```

Surf to 192.168.0.211 to confirm it is Up. Now you can remove that container
```
docker rm nginx-test-01 --force
```

## Install PiHole
Create the docker-compose file and paste the one availble on this repository
```
sudo nano docker-compose.yml
```
Run the compose file
```
sudo docker-compose up -d
```
Change the pihole password
```
sudo docker exec -it pihole bash
pihole -a -p
```

## Connect container macvlan to localhost.
With a container attached to a macvlan network, you will find that while it can contact other systems on your local network without a problem, the container will not be able to connect to your host (and your host will not be able to connect to your container). This is a limitation of macvlan interfaces: without special support from a network switch, your host is unable to send packets to its own macvlan interfaces.

pi@raspberrypi2:~/docker/pihole $ ping 192.168.0.192\
PING 192.168.0.192 (192.168.0.192) 56(84) bytes of data.\
From 192.168.0.25 icmp_seq=1 Destination Host Unreachable\
From 192.168.0.25 icmp_seq=2 Destination Host Unreachable\
From 192.168.0.25 icmp_seq=3 Destination Host Unreachable\
--- 192.168.0.192 ping statistics ---\
6 packets transmitted, 0 received, +3 errors, 100% packet loss, time 5174m


Create a new macvlan interface
```
sudo ip link add host-docker_net link eth0 type macvlan mode bridge
```
Configure it with the IP address reserved before(192.168.0.224) and bring it UP
```
sudo ip addr add 192.168.0.224/32 dev host-docker_net
sudo ip link set host-docker_net up
```
Add a route to our container subnet 192.168.0.192/27
```
sudo ip route add 192.168.0.192/27 dev host-docker_net
```

pi@raspberrypi2:~/docker/pihole $ ping 192.168.0.192\
PING 192.168.0.192 (192.168.0.192) 56(84) bytes of data.\
64 bytes from 192.168.0.192: icmp_seq=1 ttl=64 time=0.746 ms\
64 bytes from 192.168.0.192: icmp_seq=2 ttl=64 time=0.311 ms\
64 bytes from 192.168.0.192: icmp_seq=3 ttl=64 time=0.322 ms\
64 bytes from 192.168.0.192: icmp_seq=4 ttl=64 time=0.318 ms\
--- 192.168.0.192 ping statistics ---\
4 packets transmitted, 4 received, 0% packet loss, time 3098ms\
rtt min/avg/max/mdev = 0.311/0.424/0.746/0.185 ms


This configuration is not persistent.

## Persisten Change
/etc/network/interfaces

iface host-docker-net inet manual
pre-up ip link add host-docker_net link eth0 type macvlan mode bridge
pre-up ip addr add 192.168.0.224/32 dev host-docker_net
up ip link set host-docker_net up
post-up ip route add 192.168.0.192/27 dev host-docker_net
post-down ip link del dev host-docker_net
