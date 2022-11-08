# Zookeeper v 3.5.5
# This is the zookeeper docker image build file.
# The build cmd for this image is: "docker build --tag swx-zookeeper-3.5.5-docker-image:0.1.0 ." 
# The docker daemon must be running on the machine you are building this on. The tag
# version needs to be updated for each new build of the image.
# 

FROM swx-base-docker-image:0.1.0

# Labels

LABEL maintainer="support@entrib.com"
LABEL app="SWX-ZOOKEEPER-3.5.5-DOCKER-IMAGE"
LABEL version=0.1

#
# Install required packages
#

RUN apt-get -y update && apt-get install -y --fix-missing \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

# Post steps

#WORKDIR /usr/local/bin/
COPY start-zookeeper.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/start-zookeeper.sh

#reset the JAVA_HOME since zookeeper scripts append to the path in JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre


# Install zookeeper officeal image from https://archive.apache.org/dist/zookeeper/zookeeper-3.5.5/apache-zookeeper-3.5.5-bin.tar.gz

RUN wget https://archive.apache.org/dist/kafka/2.8.1/kafka_2.13-2.8.1.tgz
RUN tar -xvzf kafka_2.13-2.8.1.tgz 
RUN cd kafka_2.13-2.8.1
#CMD bin/zookeeper-server-start.sh config/zookeeper.properties
#CMD bin/kafka-server-start.sh config/server.properties

#Entrypoint. Note that if a downstream image has an ENTRYPOINT, this will not be called.

ENTRYPOINT ["/usr/local/bin/start-zookeeper.sh"]

# End.



