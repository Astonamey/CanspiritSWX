
#
# This is the kafka-consumer-service docker image build file.
# The build cmd for this image is: "docker build --tag swx-bot-kafka-consumer-service_4.4.8-376_all-docker-image:0.1.0 ." 
# The docker daemon must be running on the machine you are building this on. The tag
# version needs to be updated for each new build of the image.
# 

FROM swx-nodejs-12.22.7-docker-image:0.1.0

#
# Labels
#
LABEL maintainer="support@entrib.com"
LABEL app="SWX-KAFKA-CONSUMER-SERVICE-V4.4.8-376-DOCKER-IMAGE"
LABEL version=0.1

#TODO - create emgda user
#
# Create a non-root user to run the service. Root is bad!!
#
RUN mkdir -p /home/emgda/shopworx/logs
RUN groupadd -r emgda && useradd -d /home/emgda -s /bin/bash -r -g emgda emgda
#set pwd for emgda
RUN  echo 'emgda:Entrib!23' | chpasswd
#set homedir access
RUN chown -R emgda:emgda /home/emgda/shopworx/logs
#add emgda to the sudo'ers group. we will need it for downstream installs &
#configurations. Also useful for deployment and support teams.
RUN usermod -a -G sudo emgda
#permissions for emgda
RUN chmod 644 /home/emgda/shopworx

#USER emgda
#this point onwards, everything in the image runs under user emgda

#the deb file.
COPY swx-bot-kafka-consumer-service_4.4.8-376_all.deb /home/emgda/swx-bot-kafka-consumer-service_4.4.8-376_all.deb

#install the kafka-consumer-service
RUN dpkg -i /home/emgda/swx-bot-kafka-consumer-service_4.4.8-376_all.deb

#USER emgda

COPY kafka-consumer-service.sh /home/emgda/shopworx/kafka-consumer-service/kafka-consumer-service.sh
RUN chmod u+x /home/emgda/shopworx/kafka-consumer-service/kafka-consumer-service.sh

ENTRYPOINT ["/home/emgda/shopworx/kafka-consumer-service/kafka-consumer-service.sh"]
