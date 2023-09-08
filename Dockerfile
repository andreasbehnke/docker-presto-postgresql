FROM amazoncorretto:8

RUN yum -y update &&\
    yum -y install tar gzip

ADD https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.283/presto-server-0.283.tar.gz /tmp/presto.tar.gz

RUN mkdir -p /opt/presto &&\
    tar -zxvf /tmp/presto.tar.gz -C /opt/presto &&\
    rm /tmp/presto.tar.gz

ENV HOME /opt/presto/presto-server-0.283

WORKDIR $HOME

# copy default set of config
COPY config/ $HOME/etc/
# adding the config mounting point
VOLUME $HOME/etc/
# adding the data mounting point
VOLUME $HOME/data/

EXPOSE 8080

CMD ["/opt/presto/presto-server-0.283/bin/launcher", "run"]
