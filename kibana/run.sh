#!/bin/sh

X=`sudo docker ps -a | grep kibana`

if [ "$X" = "" ]; then
  echo "no container running..."
else
  echo "removing running container ..."
  sudo docker stop kibana
  sudo docker rm kibana
fi

#sudo docker run --name "kibana" -h 'kibana.local.net' -p 5601:80 --link elasticsearch:elasticsearch -t -i kibana_img  /bin/bash
sudo docker run --name "kibana" -h 'kibana.local.net' -p 5601:80 --link elasticsearch:elasticsearch -d kibana_img
