#!/bin/sh
sudo -v
wget -O nginx_signing.key http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
echo "deb http://nginx.org/packages/ubuntu/ xenial nginx"|sudo tee /etc/apt/sources.list.d/nginxsource.list
echo "deb-src http://nginx.org/packages/ubuntu/ xenial nginx"|sudo tee  /etc/apt/sources.list.d/nginxsource.list
sudo apt update
sudo apt install nginx -y
