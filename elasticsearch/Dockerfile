FROM trusty

MAINTAINER Piers Harding "piers@ompka.net"

ENV LANG en_NZ.UTF-8
ENV LANGUAGE en_NZ.UTF-8
ENV LC_ALL en_NZ.UTF-8
ENV HOME /root

ENV DEBIAN_FRONTEND noninteractive

RUN \
    apt-get install -y python-software-properties software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-key adv --keyserver pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4 && \
    if ! grep "elasticsearch" /etc/apt/sources.list; then echo "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" >> /etc/apt/sources.list;fi && \
    echo "Setting locales ..." && /usr/sbin/locale-gen en_US.UTF-8 && \
    /usr/sbin/locale-gen en_NZ.UTF-8 && \
    echo "Setting timezone ..." &&  /bin/echo 'Pacific/Auckland' | sudo tee /etc/timezone && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get update && \
    apt-get upgrade -y && \
    /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    /bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections && \
    apt-get clean -y

RUN \
    apt-get install -y --force-yes oracle-java7-installer && \
    apt-get install -y elasticsearch && \
    apt-get clean -y
#    apt-get clean && \
#    sed -i '/#cluster.name:.*/a cluster.name: elasticsearch' /etc/elasticsearch/elasticsearch.yml && \
#    sed -i '/#path.data: \/path\/to\/data/a path.data: /data' /etc/elasticsearch/elasticsearch.yml

EXPOSE 9200
EXPOSE 9300

VOLUME /data

ENTRYPOINT /usr/share/elasticsearch/bin/elasticsearch  -p /var/run/elasticsearch/elasticsearch.pid -Des.default.path.home=/usr/share/elasticsearch -Des.default.path.logs=/var/log/elasticsearch -Des.default.path.work=/tmp/elasticsearch -Des.default.path.conf=/etc/elasticsearch -Des.default.cluster.name=elasticsearch -Des.default.node.name=node1 -Des.default.path.data=/data
