# Test


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
