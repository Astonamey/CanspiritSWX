#!/bin/sh
#

#stop execution if any shell cmd encounters an error
set -e
echo "\n****************************\nHello! I'm the ShopWorx Socketwebhook-service Container. Starting up at: $(date)"
echo
echo "Setting socketwebhook-service configuration now ..."
echo

echo "Setting socketwebhook-service config ..."
sudo cp -r "/home/emgda/shopworx/socketwebhook/"* "/home/emgda/shopworx/socketwebhook-10190/"
echo "... done."

echo "All configs completed. Starting socketwebhook-service now..."

#start socketwebhook-service in foreground else container shall exit.
#run -d --name swx-bot-socketwebhook_4.3.11-1_all -p 10190:10190 -v socketwebhookservicelogs:/home/emgda/shopworx/logs/socketwebhook -v socetwebhookserviceconfig:/home/emgda/shopworx/socketwebhook swx-docker-vm2:5000/swx-bot-socketwebhook_4.3.11-1_all-docker-image:0.1.0 node /home/emgda/shopworx/socketwebhook/run.js
node home/emgda/shopworx/socketwebhook-10190/index.js