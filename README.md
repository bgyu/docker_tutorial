# docker_tutorial
Docker image is like an ISO image to install virtual machine in VirtualBox. Docker container is like a virtual machine in VirtualBox.

## build docker image from Dockerfile
```bash
docker build -t <ImageName> <PathToDockerfile>
```

## Run a docker image
``` bash
docker run -it <ImageName>
```

## To start an existing container which is stopped
```bash
docker start <container-name/ID>
```

## To stop a running container
```bash
docker stop <container-name/ID>
```

## Then to login to the interactive shell of a container
```bash
docker exec -it <container-name/ID> bash
```

## To start an existing container and attach to it in one command
```bash
docker start -ai <container-name/ID>
```
