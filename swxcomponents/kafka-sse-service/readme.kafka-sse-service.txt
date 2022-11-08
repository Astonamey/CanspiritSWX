1. Ports to expose - 3000.

2. Volumes to expose.
docker volume create kafkasseservicelogs [/home/emgda/shopworx/logs]
docker volume create kafkasseserviceconfig [/home/emgda/shopworx/kafka-sse-service/config]

3. Run cmd.
"
docker run -dt --name swx-bot-kafka-sse-service_4.4.6-1_all -e HOSTIP=1.1.1.1 -e KAFKAIP=2.2.2.2 -p 3000:3000 -v kafkasseservicelogs:/home/emgda/shopwoex/logs -v kafkasseserviceconfig:/home/emgda/shopworx/kafka-sse-service/config swx-bot-kafka-sse-service_4.4.6-1_all-docker-image:0.1.0 node home/emgda/shopworx/kafka-sse-service/index.js
"
