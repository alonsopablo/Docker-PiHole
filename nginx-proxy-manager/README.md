## Setup
Create a new directory and mount the docker-compose.yml file
```
docker-compose up -d
```
Access to the nginx proxy manager GUI on http://localhost:81 - Credential:admin@example.com / changeme

FWD Ports 80 (HTTP) and 443 (HTTPS) on your Router 

## Add a new Proxy Host
Nginx Proxy Manager Dashboard -> Hosts -> Add Proxy Host 

Details 
- Domain Name: your.domain
- Scheme: http or https depending on the service you would like to expose
- IP:Port: The IP and port of your service.
- Select the desire options and access list if needed

SSL
- Request New SSL Certificate
- Foce SSL

IMPORTANT: Proxy should be disable on your cloudflare domain to obtain the SSL Certificate

## Wildcard Certificate
A wildcard certificate will allow us to use a single certificate for every sub-domain, this way we dont have to request a new one each time we create a new sub-domain.

1.- SSL Certificates -> Add SSL Certificate (Lets Encrypt)\
2.- Domain Name: *.my.domain | my.domain\
3.- Use DNS Challenge\
4.- DNS Provider: Cloudflare\
5.- Cloudflare API Token\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.1.- API Tokes -> Create Token -> DNS Zone template\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.2.- Include All Zones\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.3.- Create new token and copy it\
6.- Paste your new Cloudflare API Token\
7.- Save

Now you have a Wildcard cert valid for your main domain and every subdomain.
