1.

-> building - See Dockerfile for build cmd.
(" docker build --tag swx-zookeeper-3.5.5-docker-image:0.1.0 . ")

2.

create a docker volume to store Zookeeper logs (zookeeperlogs:/bin/zoo-logs)

docker volume create zookeeperlogs using given command ( "docker volume create zookeeperlogs" )

To create docker network ( 'swxdockerized' ) using given command (" docker network create swxdockerized ")

3.

->Running the container from the image

"sudo docker run -d --name zookeepertemp -p 2181:2181 -v zookeeperlogs:/tmp/zookeeper-log --network swxdockerized swx-zookeeper-3.5.5-docker-image:0.1.0 "

4.

-> Shell session into the running container
    $> docker exec -ti <container name> /bin/bash
       root@f0b59ea4ff95:/#


5.


?

