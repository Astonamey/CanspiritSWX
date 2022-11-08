1. Ports to expose - None.

2. Volumes to expose.
docker volume create scheduleservicelogs [/home/emgda/shopworx/logs]
docker volume create scheduleserviceconfig [/home/emgda/shopworx/schedule-service/config]

3. Run cmd.
"
docker run -dt --name swx-bot-schedule-service_4.3.2-246_all-docker-image -e HOSTIP=20.198.5.5 -e USERNAME='amandwale@entrib.com' -e PASSWORD='entrib' -p 7000:7000 -v scheduleservicelogs:/home/emgda/shopwoex/logs -v scheduleserviceconfig:/home/emgda/shopworx/ruhlamat-rst-schedule-service/config swx-bot-schedule-service_4.3.2-246_all-docker-image:0.1.0 node home/emgda/shopworx/ruhlamat-rst-schedule-service/index.js
"