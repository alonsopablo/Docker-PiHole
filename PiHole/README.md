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




## Connect Mcvlan to localhost. Fast workaround
With a container attached to a macvlan network, you will find that while it can contact other systems on your local network without a problem, the container will not be able to connect to your host (and your host will not be able to connect to your container). This is a limitation of macvlan interfaces: without special support from a network switch, your host is unable to send packets to its own macvlan interfaces.

pi@raspberrypi:~ $ ping 192.168.0.201
PING 192.168.0.201 (192.168.0.201) 56(84) bytes of data.
From 192.168.0.25 icmp_seq=1 Destination Host Unreachable
From 192.168.0.25 icmp_seq=2 Destination Host Unreachable
From 192.168.0.25 icmp_seq=3 Destination Host Unreachable
From 192.168.0.25 icmp_seq=4 Destination Host Unreachable
From 192.168.0.25 icmp_seq=5 Destination Host Unreachable
From 192.168.0.25 icmp_seq=6 Destination Host Unreachable
^C
--- 192.168.0.201 ping statistics ---
8 packets transmitted, 0 received, +6 errors, 100% packet loss, time 7274ms

sudo ip link add loc-mcvlan link eth0 type macvlan mode bridge

sudo ip addr add 192.168.0.223/32 dev loc-mcvlan

sudo ip link set loc-mcvlan up

sudo ip route add 192.168.0.201/32 dev loc-mcvlan


pi@raspberrypi:~ $ ping 192.168.0.201                               
PING 192.168.0.201 (192.168.0.201) 56(84) bytes of data.
64 bytes from 192.168.0.201: icmp_seq=1 ttl=64 time=0.746 ms
64 bytes from 192.168.0.201: icmp_seq=2 ttl=64 time=0.239 ms
64 bytes from 192.168.0.201: icmp_seq=3 ttl=64 time=0.239 ms
^C
--- 192.168.0.201 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2020ms
