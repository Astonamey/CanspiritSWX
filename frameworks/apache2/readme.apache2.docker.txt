
1.
-> apache 2 version till SWX 5.x is 2.4.41

2.
-> building - See Dockerfile for build cmd.

3.
The volumes below are needed to ensure data persistence across container lifetimes.

Create a docker volume to store apach2 logs [/var/log/apache & /etc/httpd/logs]
Create a docker volume to store apach2 data [/var/www]
Create a docker volume to store apache2 config []

Modify the config files according to what the deployer does. This modification will be out of our control.

So run cmd is (image name might be different):
docker run -d --name apache2temp -e HOSTIP=1.1.1.1 -e SOCKWBHOOKIP=2.2.2.2 --network swxdocker -p 8080:80 -v apache2data:/var/www -v apache2logs:/var/log/apache -v apache2accesslogs:/etc/httpd/logs swx-apache2-2.4.x-docker-image:0.1.0


If the config is correct, typing localhost:8080 should throw an error but the url should have been redirected to Infinity. Note error is thrown because we have not installed Infinity yet.