#!/bin/sh
# Start the ZooKeeper service
# Note: Soon, ZooKeeper will no longer be required by Apache Kafka.

echo "Checking JAVA HOME. You should the see java home path now:"
echo echo "\$JAVA_HOME : $JAVA_HOME"

cd kafka_2.13-2.8.1
./bin/zookeeper-server-start.sh config/zookeeper.properties

echo "zookeeper start successfully - swx "

