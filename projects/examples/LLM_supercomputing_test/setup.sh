#!/bin/bash

# this script should run as root and has been tested with ubuntu 20.04

apt-get update && apt-get -y upgrade
apt-get install -y linux-headers-$(uname -r)
apt-get install -y build-essential make zlib1g-dev librrd-dev libpcap-dev autoconf automake libarchive-dev iperf3 htop bmon vim wget pkg-config git python-dev python3-pip libtool
apt-get install -y g++ freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
pip install --upgrade pip

##########################
### INSTALL CUDA        ##
##########################

#### THIS INSTALLS CUDA FROM THE WEB SOURCE ####

#wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
#sudo dpkg -i cuda-keyring_1.0-1_all.deb
#sudo apt-get update
#sudo apt-get -y install cuda=12.1.1-1

#### THIS INSTALLS CUDA FROM A LOCAL PACKAGE ####

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda-repo-ubuntu2004-12-1-local_12.1.0-530.30.02-1_amd64.deb
dpkg -i cuda-repo-ubuntu2004-12-1-local_12.1.0-530.30.02-1_amd64.deb
cp /var/cuda-repo-ubuntu2004-12-1-local/cuda-*-keyring.gpg /usr/share/keyrings/
apt-get update
apt-get -y install cuda

##########################
### INSTALL APPTAINER ##
##########################
cd
wget https://github.com/apptainer/apptainer/releases/download/v1.3.1/apptainer_1.3.1_amd64.deb
apt-get install -y ./apptainer_1.3.1_amd64.deb
rm -f apptainer_1.3.1_amd64.deb

wget https://github.com/apptainer/apptainer/releases/download/v1.3.1/apptainer-suid_1.3.1_amd64.deb
dpkg -i ./apptainer-suid_1.3.1_amd64.deb
rm -f apptainer-suid_1.3.1_amd64.deb

##########################
### INSTALL DOCKER      ##
##########################
cd
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

groupadd docker

systemctl enable docker
systemctl restart docker

apt-get install -y docker-compose-plugin

########################################
### INSTALL NVIDIA DOCKER TOOLKIT     ##
########################################

distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
    && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
    && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

curl -s -L https://nvidia.github.io/nvidia-container-runtime/experimental/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list

apt-get update && apt-get install -y nvidia-docker2

systemctl restart docker

############################
### SETUP POSEIDON USER ####
############################

cd
useradd -s /bin/bash -d /home/poseidon -G docker -m poseidon 

echo "poseidon     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

mkdir /home/poseidon/.ssh
chmod -R 700 /home/poseidon/.ssh
echo "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBM/ka76U6798QMOEdtrd/Uw+cwSgxDNXI1wnW9eIVq9tTVWC2oXg/BIU7vdXGedfnwIbm4eGtU5tgAhQrSZBSFo= fabric_sliver_key" >> /home/poseidon/.ssh/authorized_keys

chmod 600 /home/poseidon/.ssh/authorized_keys
chown -R poseidon:poseidon /home/poseidon/.ssh
