
1. What is container orchestration?
-> automates the deployment, management, scaling, and networking of containers. These activities
are very tricky and error prone to do manually. Also automation of these activities allows us to
respond much faster and with minimal/no errors.

2. Typical functionalities (for containers) that are taken care of by orchestration tools:
    - Provisioning & deployment
    - Config and Scheduling
    - Resource allocation
    - HA
    - Scaling
    - Load balancing, traffic routing
    - Monitoring health
    - Secure networking

In absence of orch tools, the above would need to be done manually.

3. What are tech options for orchestration tools?
 -> Kubernetes, Docker Swarm, Apache Mesos, Helios, Nomad, Cattle, OpenShift


4. What are specific constraints for Orchestration tools?
 -> Ideally, seamless ops both on prem and cloud
 -> Preferred accelerators for Ansible
 -> No vendor lockin
 -> being actively developed / maintained

5. Which orch tools are in contention for us?
 -> 1st level filtering: Kubernetes, Docker Swarm, Mesos [Cattle relies on Kubernetes, Helios is EOL, 
 OpenShift is paid only trial free. Nomad needs a lot of add on plugins too much config to be
 usable.]
 -> 2nd level: Mesos is good but looks very elaborate and maybe suited more to larger deployments that
 we arent going to have. So this leaves swarm vs Kubernetes. [https://dzone.com/articles/docker-swarm-vs-mesos-vs-kubernetes]
 -> 3rd level: Swarm has lesser enterprise grade features (simple HA, no dashboard, limited ability to
 autoscale). Kubernetes is quite complex, steep learning curve and quite involved to configure.
 See https://sensu.io/blog/kubernetes-vs-docker-swarm,
 https://www.ibm.com/cloud/blog/docker-swarm-vs-kubernetes-a-comparison,
 https://blog.engineyard.com/when-giants-clash-kubernetes-vs-docker-swarm
 In general, we want to be up & running quickly. For that reason, we shall initially go with Swarm.


------------------------------------
https://www.researchgate.net/publication/334487211_Container_Orchestration_Engines_A_Thorough_Functional_and_Performance_Comparison
https://github.com/GuillaumeRochat/container-orchestration-comparison [dated but decent]


==================================================================================
The sections below are specific to Docker Swarm.

1. Installing swarm
 -> Current versions of docker include swarm mode. It just needs to be enabled and configured. No
 separate installs required.

2. Necessary reading:
 -> https://docs.docker.com/engine/swarm/key-concepts/

3. Typical activities for a swarm:
See - https://docs.docker.com/engine/swarm/swarm-tutorial/
 -> init a cluster of docker engines in swarm mode from manager node. Mgr node must have static ip address.
 -> adding nodes to the swarm
 -> deploying app services to the swarm (e.g. swx components)
 -> managing the running swarm
 Note that swarm itself needs certain ports to be open on each host.

4. How swarm mode works:
 -> https://docs.docker.com/engine/swarm/how-swarm-mode-works/nodes/

5. How to create a service using images in a private registry
 -> https://docs.docker.com/engine/swarm/services/#create-a-service-using-an-image-on-a-private-registry

6. How to ensure that the relevant ports, volumes and docker networks are also available
when running in a swarm?
 -> First go thru - https://docs.docker.com/engine/swarm/services/#service-configuration-details
  -> Ports: https://docs.docker.com/engine/swarm/services/#publish-ports
  -> Network: Overlay Nw - https://docs.docker.com/engine/swarm/services/#connect-the-service-to-an-overlay-network
  -> Volumes: Use Data Volume mounts instead of Bind mounts. https://docs.docker.com/engine/swarm/services/#give-a-service-access-to-volumes-or-bind-mounts
  -> Reserve system resources for a service: https://docs.docker.com/engine/swarm/services/#reserve-memory-or-cpus-for-a-service
  -> Service configs: https://docs.docker.com/engine/swarm/configs/
  -> Secrets: to manage auth tokens/pwd etc - https://docs.docker.com/engine/swarm/secrets/

 All of the above are part of the Service Definition and can be provided to the swarm mgr as a command.

7. Where is the docker swarm admin guide?
 -> https://docs.docker.com/engine/swarm/admin_guide/
 -> topics like details of manager nodes, swarm health monitoring,troubleshooting,backing up swarm...

8. Docker extensibility
 -> https://docs.docker.com/engine/extend/
 -> plugins are availalbe that can be used for e.g. to utilize AWS EBS as data volumes seamlessly etc

9. Docker Private registry
 -> https://docs.docker.com/registry/deploying/
 -> https://docs.docker.com/registry/deploying/#considerations-for-air-gapped-registries
 -> https://www.digitalocean.com/community/tutorials/how-to-set-up-a-private-docker-registry-on-ubuntu-20-04

--------------

Setting up a docker registry:
 - Setup a public (TLS, authentication-enabled) public registry on azure. Images MUST be versioned to avoid field issues.
 - On site, If SWX machines will have internet access then no need for private registry.
 - On site, setup a private registry (if SWX is to run on airgapped machines). The private registry should be setup on a machine that has internet access and can sync as needed with the public SWX registry. The SWX machines will have Swarm running which will create services using this private registry.
 - If we do not want to invest in a public registry, another option is to build the images at deployment time. This will need access to the internet as most of our base images come from Dockerhub. However, doing this means that we need a way to ensure versioning of the images on site - this can be handled by strictly versioning the relevant Dockerfile
 - @todo - Licensing. How will we protect our images from being run on other machines?


--------------

Licensing dockerized SWX:
 - Notes (temp only)
    - docker env detection feature ('cat /proc/self/cgroup | grep docker | wc -l' if o/p >0 then we are in a docker container)
    - how are we licensing swx today?

--------------

Overall Plan:
- select and poc a orch tool [done]
- build swx component images [qa] --> Shobha is in the initial stages of this activity
- build swarm [qa]
- swx components' service definitions [qa]
- local and portable docker registry [sushrut] --> I will start today and target to complete tomorrow
- try out swx itself on single host [qa]
- on multiple hosts [qa]
- overall documentation [Sushrut] --> in scattered text docs in the bitbucket repo. will consolidate and refine later
- Deployment at Camso