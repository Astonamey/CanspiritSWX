1.

-> building - See Dockerfile for build cmd. 

2. create a docker volume to store tomcat logs

docker volume create tomcatlogs

3.

->Running the container from the image

docker run -d --name tomcattemp -v tomcatlogs:/usr/local/tomcat/logs -p 8080:8080 --network swxdockerized swx-tomcat-8.5.37-jre8-docker-image:0.1.0

3.

-> Shell session into the running container
    $> docker exec -ti <container name> /bin/bash
    emgda@39209897902d:/#

4.

-> ?