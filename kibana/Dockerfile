FROM trusty

MAINTAINER Piers Harding "piers@ompka.net"

ENV LANG en_NZ.UTF-8
ENV LANGUAGE en_NZ.UTF-8
ENV LC_ALL en_NZ.UTF-8
ENV HOME /root

ENV DEBIAN_FRONTEND noninteractive

RUN \
    echo "Setting locales ..." && /usr/sbin/locale-gen en_US.UTF-8 && \
    /usr/sbin/locale-gen en_NZ.UTF-8 && \
    echo "Setting timezone ..." &&  /bin/echo 'Pacific/Auckland' | sudo tee /etc/timezone && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl && \
    apt-get install -y python-software-properties software-properties-common && \
    apt-get clean -y

RUN \
    curl -s https://download.elasticsearch.org/kibana/kibana/kibana-4.0.2-linux-x64.tar.gz | tar -C /opt -xz && \
    ln -s /opt/kibana-4.0.2-linux-x64 /opt/kibana && \
    sed -i 's/port: 5601/port: 80/' /opt/kibana/config/kibana.yml && \
    sed -i 's/localhost:9200/elasticsearch:9200/' /opt/kibana/config/kibana.yml

EXPOSE 80

CMD ["/opt/kibana/bin/kibana" ]
