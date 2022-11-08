#!/bin/sh
#

#stop execution if any shell cmd encounters an error
set -e
echo "\n****************************\nHello! I'm the ShopWorx Apache2 Container. Starting up at: $(date)"
echo
echo "Setting apache2 configuration now ..."
echo

export hostip=$HOSTIP
export webhookip=$SOCKWBHOOKIP

echo "Environment variables passed to run cmd are: "
echo "The HOSTIP is: ${hostip}"
echo "The SOCKWBHOOKIP is: ${webhookip}"
echo

#
#the config files. We first copy the base files and then modify them to align with the
#deployment. The mod is made to the image copy and not the base file. We use sed to do
#this since it is part of the POSIX standard and thus is available in all Linux versions.
#NOTE that using sed here means that we can build only on Linux and cannot build on other
#OSes including Windows. This is deemed to be OK.
#
echo "Setting proxy_balancer config ..."
sed -i "s|{{client_ip}}|${hostip}|g" /etc/apache2/mods-available/proxy_balancer.conf
sed -i "s|{{socket_webhook_ip}}|${webhookip}|g" /etc/apache2/mods-available/proxy_balancer.conf
chmod 0644 /etc/apache2/mods-available/proxy_balancer.conf
echo "... done."

#the below cmd is needed because we an error when running the container which says
#"Invalid command 'RewriteEngine', perhaps misspelled or defined by a module not
#included in the server configuration"
echo "Setting default config ..."
ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
sed -i "s|{{socket_webhook_ip}}|${webhookip}|g" /etc/apache2/sites-available/000-default.conf
chmod 0644 /etc/apache2/sites-available/000-default.conf
echo "...done."

echo "Setting status config ..."
chmod 0644 /etc/apache2/mods-available/status.conf
echo "...done."

echo "Setting security config ..."
chmod 0644 /etc/apache2/conf-available/security.conf
echo "...done."

echo "Setting info.load config ..."
chmod 0644 /etc/apache2/mods-available/info.load
echo "...done."

echo "Setting cache_disk config ..."
chmod 0644 /etc/apache2/mods-available/cache_disk.conf
echo "...done."

echo "Setting mpm_event config ..."
chmod 0644 /etc/apache2/mods-available/mpm_event.conf
echo "...done."

echo "Setting mpm_worker config ..."
chmod 0644 /etc/apache2/mods-available/mpm_worker.conf
echo "...done."

echo "Setting KeepAliveTimeout config ..."
sed -i -e '$aServerName localhost' /etc/apache2/apache2.conf
sed -i -e '$aKeepAliveTimeout 35' /etc/apache2/apache2.conf
echo "...done."

echo "Enabling modules ..."
a2enmod lbmethod_bytraffic
a2enmod proxy_http
a2enmod proxy_ajp
a2enmod rewrite
echo "... done."

echo "Listing enabled modules ..."
apache2ctl -M
echo "done."

echo

echo "All configs completed. Starting Apache2 now..."

#start apache in foreground else container shall exit.
#/usr/local/apache2/bin/apachectl -D FOREGROUND
apachectl -D FOREGROUND
