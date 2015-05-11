#!/bin/sh

mkdir -p data config

X=`sudo docker ps -a | grep logstash`

if [ "$X" = "" ]; then
  echo "no container running..."
else
  echo "removing running container ..."
  sudo docker stop logstash
  sudo docker rm logstash
fi

#sudo docker run --name "logstash" -h 'logstash.local.net' -v $(pwd)/config:/etc/logstash -v $(pwd)/data:/data --link elasticsearch:elasticsearch  -t -i logstash_img  /bin/bash
sudo docker run --name "logstash" -h 'logstash.local.net' -v $(pwd)/config:/etc/logstash -v $(pwd)/data:/data --link elasticsearch:elasticsearch -d logstash_img
