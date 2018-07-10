which "nvidia-smi" > /dev/null
if [ $? -eq 0 ]; then
    echo "$(nvidia-smi)"
else
    echo " Nvidia driver is not found. Exit."
    exit 1
fi

which "docker" > /dev/null
if [ $? -eq 0 ];then
#    echo "Has docker"
    echo $(docker -v)
else
    echo "Docker is not found. Exit."
    exit 1
fi

echo "Start to install nvidia docker"

#wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
#sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

#git clone https://github.com/NVIDIA/nvidia-docker.git​
#cd nvidia-docker/
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey |    sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list |  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install nvidia-docker2
sudo pkill -SIGHUP dockerd
