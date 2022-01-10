#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

function check_internet() {
  printf "Checking if you are online..."
  wget -q --spider http://github.com
  if [ $? -eq 0 ]; then
    echo "Online. Continuing."
  else
    error "Offline. Go connect to the internet then run the script again."
  fi
}

check_internet

echo "Creating directories..."
sudo mkdir -p ./prometheus/config || error "Failed to create config directory!"
sudo mkdir -p ./prometheus/data || error "Failed to create data directory for Prometheus!"
sudo mkdir -p ./grafana/data || error "Failed to create data directory for Grafana!"
sudo touch ./grafana/grafana.ini || error "Failed to touch grafana.ini file!"
echo "Setting permissions..."
sudo chown -R 472:472 ./grafana/data || error "Failed to set permissions for Grafana data!"
echo "Done You are ready to go"
