# Docker Commands

## List all docker images
```
docker images
```

## List running containers
```bash
docker ps
```
## List all containers
```bash
docker ps -a
```

## Pull a docker image from Docker Hub
```
docker pull [name]:[tag or version]
```
```
docker pull nginx:1.27
```

## Pull latest image from Docker Hub
```
docker pull [name]
```

## Create a container from a given image and start it
```
docker run [name]:[tag or version]
```

## Runs container in background and prints the container ID
```
docker run -d [name]:[tag or version]
```
```
docker run -d nginx:1.27
```
** -d or --detach ==> detaches container and sends to background 

## Show logs of running container
```
docker logs [container ID]
```
```
docker logs bfcea1c05b73a9e428fd4cae8e0a7f45e06e0e8d5ce140f72bc9f606f3955a81
```
## Docker will pull image from Docker Hub, if it can't find in local machine. So we can skip `docker pull` and directly command `docker run`

```
docker run -d nginx:1.27
```

## Port Binding
<--! We can't access the container from our localhost as the specific port is not accessible. 
So we will tell the service to bind the container port to our localhost on our specified port
-->

### Stop one or more running container
```
docker stop [container ID]
```

### Open container on our specified port
```
docker run -d -p [localhost_Port: Container_Port] [image_name:tag or version]
```

### Go to browser
```
localhost:9000
```
### It is standard to keep the same port as container port





