#
# This is the basic swx docker image build file. All swx images depend on this.
# The build cmd for this image is: "docker build --tag swx-base-docker-image:0.1.0 ." 
# The docker daemon must be running on the machine you are building this on. The tag
# version needs to be updated for each new build of the image.
# 

#
#base layer is ubuntu 18.04 (Bionic Beaver)
#
FROM ubuntu:18.04

#
# Labels
#
LABEL maintainer="support@entrib.com"
LABEL app="SWX-BASE-DOCKER-IMAGE"
LABEL version=0.1

#
# Remove uneeded packages. Note: do not remove python3 as it seems a lot of
# ubuntu packages depend on it. See 'apt-cache rdepends python3 | grep -v python | wc -l'
#

#
# Set install mode to non interactive. this will persist to downstream (child) images too.
#
ENV DEBIAN_FRONTEND=noninteractive

#
#install required packages
#
RUN apt-get -y update && apt-get install -y --fix-missing \
    openssh-server ntp \
    openjdk-8-jdk \
    monit \
    sudo \
    wget \
    nano \
    curl \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

#post steps
RUN mkdir /var/run/sshd
COPY sshd_config /etc/ssh/
COPY init.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/init.sh

#ports
#EXPOSE 22

#
#prepare the environment to run our server (env vars)
#
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

#
#start all services that we'll need. Configure them before start if needed.
#

#
# Create a non-root user to run the service. Root is bad!!
#
#RUN mkdir -p /home/emgda
#RUN groupadd -r emgda && useradd -d /home/emgda -s /bin/bash -r -g emgda emgda
#set pwd for emgda
#RUN  echo 'emgda:Entrib!23' | chpasswd
#set homedir access
#RUN chown -R emgda:emgda /home/emgda

#add emgda to the sudo'ers group. we will need it for downstream installs &
#configurations. Also useful for deployment and support teams.
#RUN usermod -a -G sudo emgda



#
#copy runtime files
#

#
# Change ownership of the directory to the non-root user.
#

#
# Now onwards, all commands in the container will run with the created user.
#
#USER emgda

#
#Entrypoint. Note that if a downstream image has an ENTRYPOINT, this will not be called.
#
ENTRYPOINT ["init.sh"]


#
#done
#

#fin