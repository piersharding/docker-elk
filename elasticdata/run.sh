#!/bin/sh

X=`sudo docker ps -a | grep elasticdata`

if [ "$X" = "" ]; then
  echo "no container running..."
else
  echo "removing running container ..."
  sudo docker stop elasticdata
  sudo docker rm elasticdata
fi

docker run --name=elasticdata -v /data trusty sh -c 'echo volume /data'
