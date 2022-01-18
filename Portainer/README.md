# Installing and Upgrading Portainer

## Install Portainer

1.- Create a new volume to store the portainer data
```
docker volume create portainer_data
```
2.- Install Portainer container
```
docker run -d -p 8000:8000 -p 9443:9443 -p 9000:9000 --name portainer \
    --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:2.11.0
```
Test access to GUI: http://localhost:9000


## Upgrade Portainer

1.- Stop and Remove the current Portainer container
```
docker stop portainer
docker rm portainer
```
2.- Pull the latest image, in this cas 2.11.0
```
docker pull portainer/portainer-ce:2.11.0
```
3.- Recreate the Docker Container
```
docker run -d -p 8000:8000 -p 9000:9000 -p 9443:9443 \
    --name=portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:2.11.0
 ```
