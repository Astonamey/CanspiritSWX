#
# This is the nodejs docker image build file.
# The build cmd for this image is: "docker build --tag swx-nodejs-12.22.7-docker-image:0.1.0 ." 
# The docker daemon must be running on the machine you are building this on. The tag
# version needs to be updated for each new build of the image.
# 

#https://hub.docker.com/layers/node/library/node/12.22.7/images/sha256-2944e8ab47d4c14b0de8b3e8733fb2b4edb44135e82c8c0b0abfe940e509d5dc?context=explore
FROM node:12.22.7

#
# Labels
#
LABEL maintainer="support@entrib.com"
LABEL app="SWX-NODE12.22.7-DOCKER-IMAGE"
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

#the config file.

#fin