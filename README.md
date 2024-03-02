# About this Repo

Manager is free accounting software for small business. Updated daily with automatic updates option.

This is a forked Git repo from [manager-io](https://github.com/cronet/docker-manager.io), which adds support for arm64 architecture alongside amd64 architecture. Therefore it can be installed on a RaspberryPi.

The Docker image is available at [manager-io](https://hub.docker.com/r/chrborg/manager.io/). See [the Docker Hub page](https://hub.docker.com/r/chrborg/manager.io/) for the full readme on how to use this Docker image.

## APP
Dockerized https://www.manager.io

The data is stored on a external volume "/data"
## RUNNING

#### Simple run:
```
$ docker run -d chrborg/manager.io

```
#### Preferred way to run:
```
$ docker run -d \
  --name Manager \
  -p 8080:8080 \
  -v /path/to/my/data:/data \
  --restart=unless-stopped \
  chrborg/manager.io:latest
```
Your Manager will be accessible on http://dockerhost:8080

## UPDATING
<Warning>Only use this if your data is on external volume!</Warning>
#### Manual backup from Manager:
```
Open the business name -> click Backup
```
#### Manual updating:
```
$ docker stop Manager
$ docker rm Manager
$ docker pull chrborg/manager.io:latest
$ docker run -d ... (Preferred way to run)
```
Running docker prefered way, all files should already be in place. If not, restore from manual backup.
#### Automated updating:
<Warning>Use this on your own risk!</Warning>

Add "--label=com.centurylinklabs.watchtower.enable=true" to run arguments of your manager like this:
```
$ docker run -d \
  --name Manager \
  -p 8080:8080 \
  -v /path/to/my/data:/data \
  --restart=unless-stopped \
  --label=com.centurylinklabs.watchtower.enable=true \
  chrborg/manager.io:latest
```
and then start an updater container which will only update your Manager container, every time new version is released
```
$ docker run -d \
  --name Manager_Watchtower \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --restart=unless-stopped \
  --label-enable \
  containrrr/watchtower:latest
```
