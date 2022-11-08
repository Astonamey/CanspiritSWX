1.

-> building

2.

->Running the container from the image

docker run -d --name psqltemp -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=Entrib!23 -p 5432:5432 -e PGDATA=/var/lib/postgresql/data/pgdata -v psqldata:/var/lib/postgresql/data swx-psql-9.3.25-docker-image:0.1.0


3.

-> Shell session into the running container
    $> docker exec -ti <container name> /bin/bash
    root@39209897902d:/#

4.

-> creating the 'emgda' db from within the shell taken above.
    root@43d34afdccc5:/# psql -U postgres -c 'create database emgda;'
    CREATE DATABASE
    root@43d34afdccc5:/#
