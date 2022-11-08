#
# This is the tomcat docker image build file.
# The build cmd for this image is: "docker build --tag swx-tomcat-8.5.37-jre8-docker-image:0.1.0 ." 
# The docker daemon must be running on the machine you are building this on. The tag
# version needs to be updated for each new build of the image.
# 

#https://hub.docker.com/layers/tomcat/library/tomcat/8.5.37-jre8/images/sha256-2c1fea7adee97a194fdb22358fd238544a9188d9069656c4ff646ba0e65dd852?context=explore
FROM tomcat:8.5.37-jre8

#
# Labels
#
LABEL maintainer="support@entrib.com"
LABEL app="SWX-TOMCAT-8.5.37-jre8-DOCKER-IMAGE"
LABEL version=0.1

#installs
RUN apt -y update && apt-get install -y --fix-missing \
    nano \
    wget \
    curl \
    sudo \
    iproute2 \
    procps \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

#
#prepare the environment to run our server (env vars)
#
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

#
# Create a non-root user to run the service. Root is bad!!
#
RUN mkdir -p /home/emgda
RUN groupadd -r emgda && useradd -d /home/emgda -s /bin/bash -r -g emgda emgda
#set pwd for emgda
RUN  echo 'emgda:Entrib!23' | chpasswd
#set homedir access
RUN chown -R emgda:emgda /home/emgda
#add emgda to the sudo'ers group. we will need it for downstream installs &
#configurations. Also useful for deployment and support teams.
RUN usermod -a -G sudo emgda

#
#the catalina.sh config file.
#
COPY catalina.sh /usr/local/tomcat/bin/catalina.sh

#permissions for emgda on catalina.sh
RUN chmod 644 /usr/local/tomcat/bin/catalina.sh 
#make catalina.sh executable
RUN chmod +x /usr/local/tomcat/bin/catalina.sh

#
#finally, change user so that tomcat runs under emgda
#
USER emgda

#fin