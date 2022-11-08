#!/bin/sh
#

#stop execution if any shell cmd encounters an error
set -e
echo "\n****************************\nHello! I'm the ShopWorx Aggregation-Downtime-Hourly Container. Starting up at: $(date)"
echo
echo "Setting aggregation-downtime-service configuration now ..."
echo

ls -l /home/emgda/shopworx/aggregation-downtime-hourly/
export hostname=$HOSTIP
export brokerlist=$KAFKAIP
export identifier=$USERNAME
export password=$PASSWORD
export url=$MONGOIP

echo "Environment variables passed to run cmd are: "
echo "The HOSTIP is: ${hostname}"
echo "The KAFKAIP is: ${brokerlist}"
echo "The USERNAME is: ${identifier}"
echo "The PASSWORD is: ${password}"
echo "The MONGOIP is: ${url}"

echo

echo "Setting aggregation-downtime-hourly config ..."
sed -i "s|{{hostname}}|${brokerlist}|g" /home/emgda/shopworx/aggregation-downtime-hourly/config/config.json
sed -i "s|{{identifier}}|${password}|g" /home/emgda/shopworx/aggregation-downtime-hourly/config/config.json
sed -i "s|{{url}}|${url}|g" /home/emgda/shopworx/aggregation-downtime-hourly/config/config.json
chmod 0644 /home/emgda/shopworx/aggregation-downtime-hourly/config/config.json
echo "... done."

echo "All configs completed. Starting Aggregation-Downtime-Hourly now..."

#start Aggregation-Downtime-Hourly in foreground else container shall exit.
node home/emgda/shopworx/aggregation-downtime-hourly/index.js
