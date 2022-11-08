1. Ports to expose - None.

2. Volumes to expose.
docker volume create reportemailerlogs [/home/emgda/shopworx/logs]
docker volume create reportemailerconfig [/home/emgda/shopworx/swx-report-emailer/config]

3. Run cmd.
"
docker run -dt --name swx-report-emailer_4.4.9-455_all-docker-image -e HOSTIP=20.198.5.5 -e USERNAME='amandwale@entrib.com' -e PASSWORD='entrib' -p 8080:8080 -v reportemailerlogs:/home/emgda/shopwoex/logs -v reportemailerconfig:/home/emgda/shopworx/swx-report-emailer/config swx-bot-swx-report-emailer_4.4.9-455_all-docker-image:0.1.0 node home/emgda/shopworx/swx-report-emailer/index.js
"
