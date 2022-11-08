#!/bin/bash

#stop execution if any shell cmd encounters an error
set -e

echo "Hello! Starting up at: $(date)"
echo

############ SSH section START
# FOR SSH - Not sure if we need for a docker container as we can very well
# get a terminal into it for work using docker exec. Keeping as is now but
#might remove later if not needed
#sshd. need to generate keys first...
#echo "Generating SSH keys..."
#ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
#ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
#
#echo "Starting SSH ..."
#service ssh start
#/usr/sbin/sshd -D
############ SSH section END

echo

############ Java section START
#check JAVA_HOME env
echo "Checking JAVA HOME. You should the see java home path now:"
echo echo "\$JAVA_HOME : $JAVA_HOME"
echo "Checking JAVA version..."
echo "$(java -version)"
############ Java section END

echo

#any other daemons we want to start come here. Or SWX services.

#
# fin
#
echo "Startup operations completed. System ready for ShopWorx..."

##only for debugging!! uncomment only if you know what you are doing!!
#echo "Waiting to be stopped..."
#tail -f /dev/null

#fin