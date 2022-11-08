#
# This is the psql docker image build file.
# The build cmd for this image is: "docker build --tag swx-psql-9.3.25-docker-image:0.1.0 ." 
# The docker daemon must be running on the machine you are building this on. The tag
# version needs to be updated for each new build of the image.
# 

#https://hub.docker.com/_/postgres?tab=tags&page=1&ordering=last_updated&name=9.3.25
FROM postgres:9.3.25


#
# Labels
#
LABEL maintainer="support@entrib.com"
LABEL app="SWX-PSQL9.3.25-DOCKER-IMAGE"
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
COPY postgresql.conf /etc/postgresql/9.3/main/postgresql.conf

#fin