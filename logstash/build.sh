#!/bin/sh

mkdir -p data config

X=`sudo docker ps -a | grep logstash`
if [ "$X" = "" ]; then
  echo "no container running..."
else
  echo "removing running container ..."
  sudo docker stop logstash
  sudo docker rm -f logstash
fi

X=`sudo docker images | grep logstash_img`
if [ "$X" = "" ]; then
  echo "no image ..."
else
  if [ -n "$1" ]; then
    echo "removing image ..."
    sudo docker rmi logstash_img
  else
    echo "leaving image..."
  fi
fi

sudo docker build -t logstash_img .
