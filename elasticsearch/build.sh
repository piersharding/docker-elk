#!/bin/sh


X=`sudo docker ps -a | grep elasticsearch`
if [ "$X" = "" ]; then
  echo "no container running..."
else
  echo "removing running container ..."
  sudo docker stop elasticsearch
  sudo docker rm -f elasticsearch
fi

X=`sudo docker images | grep elasticsearch_img`
if [ "$X" = "" ]; then
  echo "no image ..."
else
  if [ -n "$1" ]; then
    echo "removing image ..."
    sudo docker rmi elasticsearch_img
  else
    echo "SKIPPING removing image ..."
  fi
fi

sudo docker build -t elasticsearch_img .
