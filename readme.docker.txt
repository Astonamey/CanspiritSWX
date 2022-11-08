
Ground work to be done for setting up SWX on docker. Also see @todos below
===================================================

Assumptions:
 - Docker is already installed on all machines where SWX containers are to be run.


1. Setup a local docker private registry
This is where images will be pulled from by deployment as well as the orchestrator.

<tbd>

2. Decide if any SWX component would be running in a clustered / HA mode

<tbd>

3. If all SWX components are single instance on a single machine

<tbd>

 3a. If some components are multiinstance in a single machine.

 <tbd>

4. If SWX components are across distributed machines

<tbd>

 4a. Install docker swarm / kubernetes (or reuse an existing one)

 <tbd>

5. Setting up basic docker infrastructure:

 a. Setting up the docker network
 Critical else containers will not be able to talk to each other.

 b. Setting up docker volumes
 Critical else data will get lost on container removals.
 This is discussed under the relevant framework & swxapps container details.


 Any @todos - these may or may not be needed to be actioned .
===================================================
1. NTP - makes no sense to have it inside the image (container) as the container takes the host systems time. Might need to seperately ensure NTP sync on all nodes hosting docker.
2.MMONIT - probably not needed since Swarm mode should take care of everything. Find out if we have custom mmonit scripts.
3. SED - some Dockerfiles use 'sed' utility which is available only on Linux. These will not build on Windows OSes or other OSes.
4. logrotate is ignored in the Dockerfile. Will need to be addressed.
5. In general, all config changes that are deployment specific are never part of the docker build cmd but are a) either part of the docker run cmd, or b) config is manually changed during container instantiation, or , c) we leverage something that the framework/app in question supports like environment variable.
6. Clustering related configurations are currently not part of entrypoint scripts. Thus, clusters need to be setup manually.
7. Licensing must align with the kind of licensing SWX expects. At the same time we need to protect against customers using our images on random machines OR using more than N containers for an image etc.