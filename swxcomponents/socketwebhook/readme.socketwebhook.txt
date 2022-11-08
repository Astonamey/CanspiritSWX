1. Ports to expose - None.

2. Volumes to expose.
docker volume create socketwebhookservicelogs [/home/emgda/shopworx/logs]
docker volume create socketwebhookserviceconfig [/home/emgda/shopworx/socketwebhook-10190]

3. Run cmd.
"
docker run -dt --name swx-bot-socketwebhook_4.3.11-1_all-docker-image -p 10190:10190 -v socketwebhookservicelogs:/home/emgda/shopworx/logs -v socketwebhookserviceconfig:/home/emgda/shopworx/socketwebhook-10190 swx-bot-socketwebhook_4.3.11-1_all-docker-image:0.1.0 node home/emgda/shopworx/socketwebhook-10190/index.js
"