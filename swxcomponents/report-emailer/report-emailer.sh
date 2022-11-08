#!/bin/sh
#

#stop execution if any shell cmd encounters an error
set -e
echo "\n****************************\nHello! I'm the ShopWorx report-emailer Container. Starting up at: $(date)"
echo
echo "Setting report-emailer configuration now ..."
echo


export host=$HOSTIP
export identifier=$USERNAME
export password=$PASSWORD

echo "Environment variables passed to run cmd are: "
echo "The HOSTIP is: ${hostname}"
echo "The USERNAME is: ${identifier}"
echo "The PASSWORD is: ${password}"

echo

echo "Setting report-emailer config ..."
#ques- how to add above three variables in following sed command
sed -i "s|{{hostname}}|${hostname}|g" /home/emgda/shopworx/swx-report-emailer/config/config.json
sed -i "s|{{identifier}}|${identifier}|g" /home/emgda/shopworx/swx-report-emailer/config/config.json
sed -i "s|{{password}}|${password}|g" /home/emgda/shopworx/swx-report-emailer/config/config.json
chmod 0644 /home/emgda/shopworx/swx-report-emailer/config/config.json
echo "... done."

echo "All configs completed. Starting kafka-sse-service now..."

#start report-emailer in foreground else container shall exit.
node home/emgda/shopworx/swx-report-emailer/index.js