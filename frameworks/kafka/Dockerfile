# KAFKA 2.13-2.4.0.
# This is the kafka docker image build file.
# The build cmd for this image is: "docker build --tag swx-kafka-2.13-2.4.0-docker-image:0.1.0 ." 
# The docker daemon must be running on the machine you are building this on. The tag
# Version needs to be updated for each new build of the image.
# 


# https://archive.apache.org/dist/kafka/2.8.1/kafka_2.13-2.8.1.tgz

FROM swx-base-docker-image:0.1.0

#
# Labels
#
LABEL maintainer="support@entrib.com"
LABEL app="SWX-KAFKA-2.13-2.4.0-DOCKER-IMAGE"
LABEL version=0.1

#
# Install required packages
#
RUN apt-get -y update && apt-get install -y --fix-missing \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

#
# Post steps
#
COPY start-kafka.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/start-kafka.sh

#reset the JAVA_HOME since kafka scripts append to the path in JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

#
# Install kafka official image from https://archive.apache.org/dist/kafka/2.8.1/kafka_2.13-2.8.1.tgz
#
RUN wget https://archive.apache.org/dist/kafka/2.8.1/kafka_2.13-2.8.1.tgz
RUN tar -xvzf kafka_2.13-2.8.1.tgz 
RUN cd kafka_2.13-2.8.1

#
#Modify the config 
#


# Entrypoint. Note that if a downstream image has an ENTRYPOINT, this will not be called.

ENTRYPOINT ["/usr/local/bin/start-kafka.sh"]

# end.

# Fin.
