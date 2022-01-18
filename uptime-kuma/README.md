# Uptime Kuma Installation and Configuration

Uptime Kuma is a self-hosted and open source monitoring system. You will be able to monitor HTTP, DNS, TCPC, Ping, etc and setup a custom alert system.

https://github.com/louislam/uptime-kuma

## Installation
Create a new volume to store our container data.

```
sudo mkdir -p uptimekuma/data
```

Copy the docker-copose file available on this repository and mount it.

```
sudo nano docker-compose.yml
docker-compose up -d
```
Navigate to http://localhost:3001

## Configuration
- Create an account
- Settings: Change your Timezone, appearance, security, ect.

Lets monitor our Pihole DNS for example:
- Monitor time: DNS
- Hostname: google.com
- Heartbeat Interval: 60 Seconds
- Resolver DNS: 172.20.0.7 (This is my pihole docker container IP)
