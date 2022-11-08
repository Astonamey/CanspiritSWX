Some important notes:

 - Always remember that if you are creating a container from an image that points to a volume
 which already has the database then you do not need to recreate the db, users and their roles! same
 goes if you are starting a stopped container.

 Mongo 3.6.4 official doc link - https://docs.mongodb.com/v3.6/
 

IF YOUR HOST MACHINE IS WINDOWS or OSX:
---------------------------------------

1.
->Starting the mongodb container.

If you are running on a Linux based host, ignore this current item #1.

When running the Linux-based MongoDB images on Windows and OS X hosts, the file systems used to share 
between the host system and the Docker container is not compatible with the memory mapped files used 
by MongoDB (docs.mongodb.org and related jira.mongodb.org bug). This means that it is not possible 
to run a MongoDB container with the data directory mapped to the host. To persist data between container 
restarts, we recommend using a local named volume instead (see docker volume create). Alternatively 
you can use the Windows-based images on Windows.

The following works on Windows host.

First create a volume to store mongo related data files.
C:\>docker volume create mongodbdata

First time running a container, no swx mongodb available:
C:\>docker run --name mongotemp -e MONGO_INITDB_ROOT_USERNAME=emgda-root -e MONGO_INITDB_ROOT_PASSWORD=ShopWorx110T -p 27017:27017 -v mongodbdata:/var/lib/mongodb -v mongodbdata:/var/log/mongodb -d swx-mongod-3.6.4-docker-image:0.1.0 --config /etc/mongod.conf

Running a new container on a volume which already has the swx mongodb:
C:\>docker run --name mongotemp -p 27017:27017 -v mongodbdata:/var/lib/mongodb -v mongodbdata:/var/log/mongodb -d swx-mongod-3.6.4-docker-image:0.1.0 --config /etc/mongod.conf

On Windows, the volume's location on the drive will be at:
\\wsl$\docker-desktop-data\version-pack-data\community\docker\volumes\<your volume name>

In the above we would ideally like to have a separate dir for the logs but that isnt working well
even when we create another docker volume to store logs. This is something to fix/find fix on. Thus
till then, the logs shall also reside in the same docker volume as mongodb data.


IF YOUR HOST MACHINE IS LINUX:
---------------------------------------
1.
->Starting the mongodb container. As above.



THESE STEPS ARE COMMON IRRESPECTIVE OF YOUR HOST MACHINE OS:
------------------------------------------------------------

2.

->Getting a shell into your running swx mongo container:

docker exec -ti <container name> /bin/bash

3.

->Logging into mongo shell using the root user (within the container shell):

root@6e9f4a5774cd:/home# mongo admin -u emgda-root --authenticationDatabase admin -p "ShopWorx110T"

->Logging into mongo shell remotely:

$>mongo admin -u emgda-root --authenticationDatabase admin -p "ShopWorx110T" --port 27017 --host <ip>

OR you can pass the above values to MongoDB Compass from a remote machine.

4.

-> creating db's

Login to mongo container via docker shell (2 above). In the shell login to the mongo shell (3 above).

 a. Type 'show dbs'. You should see something like the following output:
    > show dbs
    admin   0.000GB
    config  0.000GB
    local   0.000GB
 b. Type the following (all cmds after '>' are the ones you need to type and run):
    > use emgda
    switched to db emgda
    > db.aboutme.insert({"name":"SWX emgda db"})
    WriteResult({ "nInserted" : 1 })
    > show dbs
    admin   0.000GB
    config  0.000GB
    emgda   0.000GB
    local   0.000GB
    > use emgda_internals
    switched to db emgda_internals
    >  db.aboutme.insert({"name":"SWX emgda_internals db"})
    WriteResult({ "nInserted" : 1 })
 c. To verify type the following cmd and the output should be similar to the one shown:
    > use admin
    switched to db admin
    > show dbs
    admin            0.000GB
    config           0.000GB
    emgda            0.000GB
    emgda_internals  0.000GB
    local            0.000GB
    >

5.

-> creating users:

Login to mongo container via docker shell (2 above). In the shell login to the mongo shell (3 above).

Here type the cmd: 'use admin'. Press enter.

One by one paste the following statements. You can copy the entire statement and paste it into the
mongo shell. After pasting press enter to run it. If all goes well you will see the success message
as given below.
 a. create user emgda with role userAdminAnyDatabase for admin db
    > use admin
    > db.createUser(
        ... {
        ... user: "emgda",
        ... pwd: "ShopWorx110T",
        ... roles:
        ... [
        ... { role: "userAdminAnyDatabase", db: "admin"},
        ... ]
        ... }
        ... );

    If successful you should see this output from the mongo shell:
    
    Successfully added user: {
            "user" : "emgda",
            "roles" : [
                    {
                            "role" : "userAdminAnyDatabase",
                            "db" : "admin"
                    }
            ]
    }

 b. create user emgda with role readWrite for emgda db

    > use emgda
    switched to db emgda
    > db.createUser(
    ... ... {
    ... ... user: "emgda",
    ... ... pwd: "ShopWorx110T",
    ... ... roles:
    ... ... [
    ... ... { role: "readWrite", db: "emgda"},
    ... ... ]
    ... ... }
    ... ... );
    Successfully added user: {
            "user" : "emgda",
            "roles" : [
                    {
                            "role" : "readWrite",
                            "db" : "emgda"
                    }
            ]
    }
    >

 c. create user emgda with role readWrite for emgda_internals db 

    > use emgda_internals
    switched to db emgda_internals
    > db.createUser(
    ... ... {
    ... ... user: "emgda",
    ... ... pwd: "ShopWorx110T",
    ... ... roles:
    ... ... [
    ... ... { role: "readWrite", db: "emgda_internals"},
    ... ... ]
    ... ... }
    ... ... );
    Successfully added user: {
            "user" : "emgda",
            "roles" : [
                    {
                            "role" : "readWrite",
                            "db" : "emgda_internals"
                    }
            ]
    }
    >

6. creating indexes on swx collections. Run as below. It's ok if the collection doesnt exist,
mongo will create it.

 a. First auth with emgda db
        root@5ab12102865d:/# mongo emgda -u emgda --authenticationDatabase emgda -p "ShopWorx110T"
        MongoDB shell version v3.6.4
        connecting to: mongodb://127.0.0.1:27017/emgda
        MongoDB server version: 3.6.4
        > db
        emgda
 
 b. collection indices:

        > db.cycletime.createIndex({customerId : 1, elementId : 1, siteId : 1, createdTimestamp : 1, purged : 1}, {background : true, sparse : true})
        {
                "createdCollectionAutomatically" : true,
                "numIndexesBefore" : 1,
                "numIndexesAfter" : 2,
                "ok" : 1
        }
        > db.downtime.createIndex({customerId : 1, elementName : 1, siteId : 1, createdTimestamp : 1, machinename : 1, planid: 1, year:1, month:1, week:1, day: 1}, {name: 'big_index', background: true, sparse: true})
        {
                "createdCollectionAutomatically" : true,
                "numIndexesBefore" : 1,
                "numIndexesAfter" : 2,
                "ok" : 1
        }
        > db.rejection.createIndex({customerId :1, elementId : 1, siteId : 1, createdTimestamp : 1}, {background : true, sparse : true})
        {
                "createdCollectionAutomatically" : true,
                "numIndexesBefore" : 1,
                "numIndexesAfter" : 2,
                "ok" : 1
        }
        > db.default.createIndex({customerId :1, elementId : 1, siteId : 1, createdTimestamp : 1}, {background : true, sparse : true})
        {
                "createdCollectionAutomatically" : true,
                "numIndexesBefore" : 1,
                "numIndexesAfter" : 2,
                "ok" : 1
        }
        > db.provisioning.createIndex({customerId :1, elementId : 1, siteId : 1, createdTimestamp : 1}, {background : true, sparse : true})
        {
                "createdCollectionAutomatically" : true,
                "numIndexesBefore" : 1,
                "numIndexesAfter" : 2,
                "ok" : 1
        }
        > db.aggregatehourly.createIndex({customerId :1, siteId : 1, date: 1}, {background : true, sparse : true})
        {
                "createdCollectionAutomatically" : true,
                "numIndexesBefore" : 1,
                "numIndexesAfter" : 2,
                "ok" : 1
        }
        > db.aggregateshift.createIndex({customerId :1, siteId : 1, date: 1, machinename: 1, shift: 1}, {background : true, sparse : true})
        {
                "createdCollectionAutomatically" : true,
                "numIndexesBefore" : 1,
                "numIndexesAfter" : 2,
                "ok" : 1
        }
        > db.aggregateplan.createIndex({customerId :1, siteId : 1, date: 1, planid: 1}, {background : true, sparse : true})
        {
                "createdCollectionAutomatically" : true,
                "numIndexesBefore" : 1,
                "numIndexesAfter" : 2,
                "ok" : 1
        }
        > db.aggregateplan.createIndex({customerId :1, siteId : 1, assetid: 1, partname: 1, machinename: 1, toolname: 1, moldname: 1}, {background : true, sparse : true})
        {
                "createdCollectionAutomatically" : false,
                "numIndexesBefore" : 2,
                "numIndexesAfter" : 3,
                "ok" : 1
        }
        > db.asmDowntimeHourlyCache.createIndex( { 'createdAt': 1 }, { expireAfterSeconds: 3600 } )
        {
                "createdCollectionAutomatically" : true,
                "numIndexesBefore" : 1,
                "numIndexesAfter" : 2,
                "ok" : 1
        }
        > db.asmDowntimeShiftCache.createIndex( { 'createdAt': 1 }, { expireAfterSeconds: 86400 } )
        {
                "createdCollectionAutomatically" : true,
                "numIndexesBefore" : 1,
                "numIndexesAfter" : 2,
                "ok" : 1
        }
        >

