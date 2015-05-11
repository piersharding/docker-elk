#!/bin/sh

X=`sudo docker ps -a | grep elasticsearch`

if [ "$X" = "" ]; then
  echo "no container running..."
else
  echo "removing running container ..."
  sudo docker stop elasticsearch
  sudo docker rm elasticsearch
fi

# sudo docker run --name "elasticsearch" -h 'elasticsearch.local.net' -p 9200:9200 -t -i elasticsearch_img  /bin/bash
sudo docker run --name "elasticsearch" -h 'elasticsearch.local.net' -p 9200:9200 --volumes-from elasticdata -d elasticsearch_img
