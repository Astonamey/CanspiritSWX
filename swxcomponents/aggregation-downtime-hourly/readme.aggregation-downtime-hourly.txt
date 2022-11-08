1. Ports to expose - None.

2. Volumes to expose.
docker volume create aggregationdowntimehourlylogs [/home/emgda/shopworx/logs]
docker volume create aggregationdowntimehourlyconfig [/home/emgda/shopworx/aggregation-downtime-hourly/config]

3. Run cmd.
"
docker run -dt --name aggregation-downtime-hourly -e HOSTIP=20.198.5.5 -e KAFKAIP=20.198.72.81 -e USERNAME='amandwale@entrib.com' -e PASSWORD='entrib' -e MONGOIP=20.198.5.5 -v aggregationdowntimehourlylogs:/home/emgda/shopworx/logs -v aggregationdowntimehourlyconfig:/home/emgda/shopworx/aggregation-downtime-hourly/config swx-docker-vm2:5000/aggregation-downtime-hourly-docker-image:0.1.0 node home/emgda/shopworx/aggregation-downtime-hourly/index.js
"
