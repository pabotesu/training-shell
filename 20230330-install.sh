#!/bin/bash -eu

# set permit password
printf "password: "
read password

set +e
# remove old docker
echo $password | sudo yum remove docker \
                                 docker-common \
                                 docker-selinux \
                                 docker-engine
set -e

# centos 7.9 install docker & docker-compose

## update pakcages 
echo $password | sudo yum update -y

## insatll virtualzation packages 
echo $password | sudo yum install -y yum-utils \
                                     device-mapper-persistent-data \
                                     lvm2

## install peripheral packages
echo $password | sudo yum install -y wget \
                                     curl \
                                     unzip

## install repo
echo $password | sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

## install docker-ce
echo $password | sudo yum install -y docker-ce \
                                     docker-ce-cli \ 
                                     containerd.io

## install docker-compose

### download docker-compose
echo $password | sudo curl -L https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

### grant of exe authority
echo $password | sudo chmod +x /usr/local/bin/docker-compose


## belong to docker
set +e

echo $password | sudo groupadd docker 

set -e

echo $password | sudo gpasswd -a $USER docker


# centos 7.9 insatll lazydocker

## download lazy docker
wget https://github.com/jesseduffield/lazydocker/releases/download/v0.20.0/lazydocker_0.20.0_Linux_x86_64.tar.gz

## deployment lazydocker
tar xvzf lazydocker*.tar.gz

## copy lazydocker 
echo $password | sudo cp lazydocker /usr/local/bin/


# enable --now docker
echo $password | sudo systemctl enable --now docker


