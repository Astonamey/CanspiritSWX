#!/bin/sh
#

#stop execution if any shell cmd encounters an error
set -e
echo "\n****************************\nHello! I'm the ShopWorx Kafka-consumer-service Container. Starting up at: $(date)"
echo
echo "Setting kafka-consumer-service configuration now ..."
echo


export hostname=$HOSTIP
export brokerlist=$KAFKAIP

echo "Environment variables passed to run cmd are: "
echo "The HOSTIP is: ${hostname}"
echo "The KAFKAIP is: ${brokerlist}"

echo

echo "Setting kafka-consumer-service config ..."
sed -i "s|{{hostname}}|${brokerlist}|g" /home/emgda/shopworx/kafka-consumer-service/config/config.json
chmod 0644 /home/emgda/shopworx/kafka-consumer-service/config/config.json
echo "... done."

echo "All configs completed. Starting kafka-consumer-service now..."

#start kafka-sse-service in foreground else container shall exit.
#run -d --name swx-bot-kafka-sse-service_4.4.6-1_all -v kafkasseservicelogs:/home/emgda/shopworx/logs/kafka-sse-service -v kafkasseserviceconfig:/home/emgda/shopworx/kafka-sse-service swx-docker-vm2:5000/swx-bot-kafka-sse-service_4.4.6-1_all-docker-image:0.1.0 node /home/emgda/shopworx/kafka-sse-service/config/run.js
#node home/emgda/shopworx/kafka-consumer-service/index.js