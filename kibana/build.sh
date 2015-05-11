#!/bin/sh


X=`sudo docker ps -a | grep kibana`
if [ "$X" = "" ]; then
  echo "no container running..."
else
  echo "removing running container ..."
  sudo docker stop kibana
  sudo docker rm -f kibana
fi

X=`sudo docker images | grep kibana_img`
if [ "$X" = "" ]; then
  echo "no image ..."
else
  if [ -n "$1" ]; then
    echo "removing image ..."
    sudo docker rmi kibana_img
  else
    echo "leaving image..."
  fi
fi

sudo docker build -t kibana_img .
