1. Ports to expose - 3000.

2. Volumes to expose.
docker volume create kafkaconsumerservicelogs [/home/emgda/shopworx/logs]
docker volume create kafkaconsumerserviceconfig [/home/emgda/shopworx/kafka-consumer-service/config]

3. Run cmd.
"
docker run -dt --name swx-bot-kafka-consumer-service_4.4.8-376_all -e HOSTIP=20.198.5.5 -e KAFKAIP=20.198.72.81 -p 3000:3000 -v kafkaconsumerservicelogs:/home/emgda/shopwoex/logs -v kafkaconsumerserviceconfig:/home/emgda/shopworx/kafka-consumer-service/config swx-bot-kafka-consumer-service_4.4.8-376_all-docker-image:0.1.0 node home/emgda/shopworx/kafka-consumer-service/index.js

