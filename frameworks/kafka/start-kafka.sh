#!/bin/sh
# Start the ZooKeeper service
# Note: Soon, ZooKeeper will no longer be required by Apache Kafka.

#check and display critical env vars
echo "Checking JAVA HOME. You should the see java home path now:"
echo echo "\$JAVA_HOME : $JAVA_HOME"

export zkip=$ZKIP

echo "Environment variables passed to run cmd are: "
echo "The ZOOKEEPER IP is: ${zkip}"
echo

#move into kafka dir
cd kafka_2.13-2.8.1

#update kafka server.properties with zookeeper ip(s)
sed -i "s|zookeeper.connect=localhost:2181|zookeeper.connect=${zkip}:2181|g" config/server.properties

#for debug only. remove later
echo " "
echo " "
cat config/server.properties
echo " "
echo " "
#for debug only. remove later

# Start the Kafka broker service
./bin/kafka-server-start.sh config/server.properties

echo "start kafka successfully"
