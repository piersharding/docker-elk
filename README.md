# Yet another ELK

Yet another ELK is a set of notes for me to remember how to run up a Docker based solution for Elasticsearch, Logstash and Kibana as an instant platform for timeseries (mostly) based Analytics.


## Installing dependencies

Docker 1.3+ - https://docs.docker.com/installation/ubuntulinux/
docker-compose  1.2.0+ - https://docs.docker.com/compose/

Install Docker and Docker Compose, and then build a base image - I don't want to rely on anyone elses so I cook mine like thus:

```
 #!/bin/sh

 # build a minimal image and import into private Docker registry
 sudo rm -rf trusty64

 debootstrap --include=ubuntu-minimal --components main,universe trusty trusty64
 cd trusty64 && sudo chroot .
 apt-get install wget && wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb && sudo dpkg -i puppetlabs-release-trusty.deb && rm puppetlabs-release-trusty.deb && sudo apt-get update
 apt-get install software-properties software-properties-common
 apt-get install puppet
 gem install hiera-eyaml
 perl -i -ne 'print unless /templatedir/' /etc/puppet/puppet.conf
 cd ..
 IID=`sudo tar -C trusty64 -c . | sudo docker import - trusty`
 sudo docker images
 sudo docker tag $IID dragon.local.net:5000/ubuntu
 sudo docker push dragon.local.net:5000/ubuntu
```

## build individual containers

The four containers required can be built individually - note, the persistent storage for Elasticseach is in a data only container - elasticdata:

* elasticdata - `cd elasticdata && ./run.sh`
* elasticsearch - `cd elasticsearch && ./build.sh && ./run.sh`
* logstash - `cd elasticsearch && ./build.sh && ./run.sh`
* kibana - `cd elasticsearch && ./build.sh && ./run.sh`

Have a look at the different build.sh and run.sh scripts to see how the containers are linked together

## control everything with docker-compose

Docker compose enables the orchestration of the docker containers to be managed from one place (very convenient!).  We still need to build the images and create the persistent data storage in a data only container - elasticdata:

* elasticdata - `cd elasticdata && ./run.sh`
* build images - `for i in elasticsearch logstash kibana; do echo "Building $i..."; cd $i && ./build.sh && cd ..; done`
* launch with docker -compose - `docker-compose up`

Finally - use logstash to pour logs into Elasticsearch - logstash config files are kept in logstash/config, and the logstash/data directory is mounted as a volume /data in the logstash container so that it can be used a means of communication - see logstash/config/test.conf for an example
