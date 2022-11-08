
#
# This is the kafka-sse-service docker image build file.
# The build cmd for this image is: "docker build --tag swx-bot-kafka-sse-service_4.4.6-1_all-docker-image:0.1.0 ." 
# The docker daemon must be running on the machine you are building this on. The tag
# version needs to be updated for each new build of the image.
# 

FROM swx-nodejs-12.22.7-docker-image:0.1.0

#
# Labels
#
LABEL maintainer="support@entrib.com"
LABEL app="SWX-KAFKA-SSE-SERVICE-V4.4.6-1-DOCKER-IMAGE"
LABEL version=0.1

RUN mkdir -p /home/emgda
RUN groupadd -r emgda && useradd -d /home/emgda -s /bin/bash -r -g emgda emgda
#set pwd for emgda
RUN  echo 'emgda:Entrib!23' | chpasswd
#set homedir access
RUN chown -R emgda:emgda /home/emgda
#add emgda to the sudo'ers group. we will need it for downstream installs &
#configurations. Also useful for deployment and support teams.
RUN usermod -a -G sudo emgda

#get the debian from the build server
#RUN wget http.......

#the catalina.sh config file.
#
COPY swx-bot-kafka-sse-service_4.4.6-1_all.deb /home/swx-bot-kafka-sse-service_4.4.6-1_all.deb

#permissions for emgda
RUN chmod 644 /home/emgda

#install the kafka-sse-service
RUN dpkg -i /home/swx-bot-kafka-sse-service_4.4.6-1_all.deb

USER emgda
