#!/bin/bash


#result=$( echo "$nvidia_driver" | grep "Driver Version" )
reset_terminal=$(tput sgr0)
      
#OS type  
os_type=$(uname -o)  
echo "\033[32m" "OS type:" $reset_terminal $os_type
  
#OS release version  
os_version=$(cat /etc/issue | grep "Ubuntu")   
if [ -n "$os_version" ];
then
  echo "\033[32m" "OS release version:" $reset_terminal $os_version
else
  echo "The operation system is not Ubuntu. Exit!"
  exit 1
fi

which "docker" > /dev/null
if [ $? -eq 0 ];then
    echo "Docker has been installed in this system:"
    echo $(docker -v)
    echo "Exit!"
    exit 1
fi

is_1404=$(cat /etc/issue | grep "14.04")
if [ -n "$is_1404" ];then
  sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
fi

#Check Kernel Version
V1=3
V2=10
kernel_version=$(uname -r)
echo $kernel_version
Ver=${kernel_version%.*}
C_V1=${Ver%.*}
C_V2=${Ver#*.}
if [ $C_V1 -lt $V1 ];then
  echo "Linux Kernel Version is now $C_V1.$C_V2 and less than $V1.$V2, cannot support the docker."
  exit 1
elif [ $C_V1 -eq $V1 ];then
  if [ $C_V2 -lt $V2 ];then
    echo "Linux Kernel Version is now $C_V1.$C_V2 and less than $V1.$V2, cannot support the docker."
    exit 1
  fi
fi
echo "Linux Kernel Version is now $C_V1.$C_V2"

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
sudo apt-get install -y linux-image-extra-$(uname -r)
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update

sudo apt-get install docker-ce
