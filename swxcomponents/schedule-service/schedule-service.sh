#!/bin/sh
#

#stop execution if any shell cmd encounters an error
set -e
echo "\n****************************\nHello! I'm the ShopWorx Schedule-service Container. Starting up at: $(date)"
echo
echo "Setting schedule-service configuration now ..."
echo


export host=$HOSTIP
export identifier=$USERNAME
export password=$PASSWORD

echo "Environment variables passed to run cmd are: "
echo "The HOSTIP is: ${host}"
echo "The USERNAME is: ${identifier}"
echo "The PASSWORD is: ${password}"

echo

echo "Setting schedule-service config ..."
#ques- how to add above three variables in following sed command
sed -i "s|{{host}}|${host}|g" /home/emgda/shopworx/schedule-service/config/config.json
sed -i "s|{{identifier}}|${identifier}|g" /home/emgda/shopworx/schedule-service/config/config.json
sed -i "s|{{password}}|${password}|g" /home/emgda/shopworx/schedule-service/config/config.json
chmod 0644 /home/emgda/shopworx/schedule-service/config/config.json
echo "... done."

echo "All configs completed. Starting schedule-service now..."

#start schedule-service in foreground else container shall exit.
#run -d --name swx-bot-kafka-sse-service_4.4.6-1_all -v scheduleservicelogs:/home/emgda/shopworx/logs/scehdule-service -v scheduleserviceconfig:/home/emgda/shopworx/schedule-service/config swx-docker-vm2:5000/swx-bot-schedule-service_4.3.2-246_all-docker-image:0.1.0 node /home/emgda/shopworx/schedule-service/config/run.js
node home/emgda/shopworx/schedule-service/index.js