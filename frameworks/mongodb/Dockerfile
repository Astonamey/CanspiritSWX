#
# This is the mongodb docker image build file.
# The build cmd for this image is: "docker build --tag swx-mongod-3.6.4-docker-image:0.1.0 ." 
# The docker daemon must be running on the machine you are building this on. The tag
# version needs to be updated for each new build of the image.
# 

#https://hub.docker.com/_/mongo?tab=tags&page=1&ordering=last_updated&name=3.6.4
FROM mongo:3.6.4


#
# Labels
#
LABEL maintainer="support@entrib.com"
LABEL app="SWX-MONGOD3.6.4-DOCKER-IMAGE"
LABEL version=0.1

#installs
RUN apt -y update && apt-get install -y --fix-missing \
    nano \
    wget \
    curl \
    sudo \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

#
#prepare the environment to run our server (env vars)
#

#the mongod config file.
COPY mongod.conf /etc/mongod.conf

#fin