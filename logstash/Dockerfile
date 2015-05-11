FROM trusty

MAINTAINER Piers Harding "piers@ompka.net"

ENV LANG en_NZ.UTF-8
ENV LANGUAGE en_NZ.UTF-8
ENV LC_ALL en_NZ.UTF-8
ENV HOME /root

ENV DEBIAN_FRONTEND noninteractive

#RUN apt-get update
#RUN apt-get install -y curl
RUN \
    apt-get install -y python-software-properties software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4 && \
    if ! grep "logstash" /etc/apt/sources.list; then echo "deb http://packages.elasticsearch.org/logstash/1.4/debian stable main" >> /etc/apt/sources.list;fi && \
    echo "Setting locales ..." && /usr/sbin/locale-gen en_US.UTF-8 && \
    /usr/sbin/locale-gen en_NZ.UTF-8 && \
    echo "Setting timezone ..." &&  /bin/echo 'Pacific/Auckland' | sudo tee /etc/timezone && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get update && \
    apt-get upgrade -y && \
    /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    /bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections && \
    apt-get clean -y


RUN \
    apt-get install -y oracle-java8-installer && \
    apt-get install -y logstash logstash-contrib && \
    apt-get clean

#ENTRYPOINT /opt/logstash/bin/logstash --debug -f /etc/logstash
ENTRYPOINT /opt/logstash/bin/logstash -f /etc/logstash
