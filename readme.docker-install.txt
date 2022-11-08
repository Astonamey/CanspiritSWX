How to install and configure docker on various OSes.

1. SLES 15 SP3
 
 -> Docker is bundled but we need to start the service: 'sudo systemctl start docker'
 -> In SLES/Open Suse: As "root" use the:
    - zypper command for package management
    - yast command for configuration management

2. Ubuntu 20.04, 18.04
 -> Follow instructions here - https://docs.docker.com/engine/install/ubuntu/#prerequisites