
#
# This is the apache2 docker image build file.
# The build cmd for this image is:
# "docker build --tag swx-apache2-2.4.x-docker-image:0.1.0 ." Use '--no-cache' option
# to build without using the build cache. 
# The docker daemon must be running on the machine you are building this on. The tag
# version needs to be updated for each new build of the image.
# 

FROM swx-base-docker-image:0.1.0

#
# Labels
#
LABEL maintainer="support@entrib.com"
LABEL app="SWX-APACHE2-2.4.x-DOCKER-IMAGE"
LABEL version=0.1

#installs
RUN apt -y update && apt-get install -y --fix-missing \
    nano \
    wget \
    curl \
    sudo \
    iproute2 \
    procps \
    build-essential \
    libapr1-dev \
    libaprutil1-dev \
    && apt-get clean && rm -rf /tmp/* /var/tmp/*

#
# Post steps
#
COPY set-apache2-config.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/set-apache2-config.sh

#
# Prepare the environment to run our server (env vars)
#
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

#
# Install apache2 & needed libs. We stick to a specific version to avoid nasty surprises.
#
RUN apt-get -y install apache2=2.4.29-1ubuntu4.25

#
#Ready the various config files
#
COPY proxy_balancer.conf /etc/apache2/mods-available/proxy_balancer.conf
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY status.conf /etc/apache2/mods-available/status.conf
COPY security.conf /etc/apache2/conf-available/security.conf
COPY info.load /etc/apache2/mods-available/info.load
COPY cache_disk.conf /etc/apache2/mods-available/cache_disk.conf
COPY mpm_event.conf /etc/apache2/mods-available/mpm_event.conf
COPY mpm_worker.conf /etc/apache2/mods-available/mpm_worker.conf

# Entrypoint. This will set the config as per what is passed into the Docker RUN cmd.

ENTRYPOINT ["/usr/local/bin/set-apache2-config.sh"]

# end.

# Fin.