1.

-> building - See Dockerfile for build cmd.

2.

create a docker volume to store Kafka logs (Kafkalogs:/tmp/kafka-logs)
Create a docker volume to store kafka data (kafkadata:/usr/kafka-data)
docker volume create for kafkalogs using given command ( "docker volume create kafkalogs" )
Docker volume create for kafkadata using given command ( "docker volume create kafkadata" )

Create a docker network ( 'swxdockerized' ) using given command ( " docker network create swxdockerized " )

3.

->Running the container from the image

"sudo docker run -d --name kafkatemp -p 9092:9092 -e ZKIP=2.2.2.2 -v kafkalogs:/tmp/kafka-log -v kafkadata:/usr/kafka-data --network swxdockerized swx-kafka-2.13-2.4.0-docker-image:0.1.0 "

4.

-> Shell session into the running container
    $> docker exec -ti <container name> /bin/bash
       root@f0b59ea4ff95:/#


5.


?

