## Setup
Create a new directory and mount the docker-compose.yml file
```
docker-compose up -d
```
Access to the nginx proxy manager GUI on http://localhost:81 - Credential:admin@example.com / changeme

FWD Ports 80 (HTTP) and 443 (HTTPS) on your Router \

## Add a new Proxy Host
Nginx Proxy Manager Dashboard -> Hosts -> Add Proxy Host \
Details \
- Domain Name: your.domain
- Scheme: http or https depending on the service you would like to expose
- IP:Port: The IP and port of your service
- Select the desire options and access list if needed
SSL \
- Request New SSL Certifica
- Force SSL, HTTP/2 Support and HSTS Enabled

IMPORTANT: Proxy should be disale on the domain name you will use during the setup process
