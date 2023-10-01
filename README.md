# docker_tutorial
Docker image is like an ISO image to install virtual machine in VirtualBox. Docker container is like a virtual machine in VirtualBox.

## build docker image from Dockerfile
```bash
docker build -t <ImageName> <PathToDockerfile>
```

Example: build a docker image with ubuntu image as the base and ping installed
```bash
docker build --tag my-ubuntu-image -<<EOF
FROM ubuntu:22.04
RUN apt update && apt install iputils-ping --yes
EOF
```
Then run it:
```bash
docker run -it --rm my-ubuntu-image
```
This will run the new image interactively and remove the container after exit the container.


## Run a docker image
``` bash
docker run -it <ImageName> --name MyDocker
```
This will run docker container named "MyDocker" in interactive mode and attaced to a tty so that it won't exit immediately.
* -i: --interactive, run docker interactively, Keep STDIN open even if not attached
* -t: --tty: attach,  Allocate a pseudo-TTY for container
* --name:  Assign a name to the container


## To start an existing container which is stopped
```bash
docker start <container-name/ID>
```

## To login a running container
```
docker attach <container-name/ID>
```
Combine with **docker start** with **docker attach**, we can start a stopped container and attach to the running shell.

## To stop a running container
```bash
docker stop <container-name/ID>
```

## List containers
```bash
docker ps  # List running containers, it wont' show stopped containers
docker ps -a # List all containers, including stopped containers
```

## To login to the interactive shell of a container
```bash
docker exec -it <container-name/ID> bash
```
The command is similar to the combination of **docker start** and **docker attach**.

## To start an existing container and attach to it in one command
```bash
docker start -ai <container-name/ID>
```

## Volume mounts
```bash
docker volume create my-volume   # Create a docker volume
docker run -it --rm --mount source=my-volume,destination==/my-data ubuntu:22.04  # Mount the volume
docker run -it --rm -v my-volume:/my-data ubuntu:22.04 # Same as above command but shorter
```
This will create a volume and mount to /my-data in the docker container, which you can save persistent data.

## Bind mounts
```bash
docker run -it --rm --mount type=bind,source="${PWD}"/my-data,destination=/my-data ubuntu:22.04
```
This will mount my-data in current directory to /my-data in container, and the data will be persistent when you store data in /my-data.

With volume mount, you can't access its data directly in your host system, but it has better performance.
With bind mount, you can access the data directly in your host system, but it has poor performance sometimes, especially with lots of read and write.

