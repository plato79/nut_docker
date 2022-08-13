# NUT Docker

This compose file builds an image for [NUT](https://github.com/blawar/nut)

## Requirements:

### Files:

First you need some files:

- keys.txt 
- users.conf (optional)
- nut.conf (optional)

### Modifications:

* Changes to .env file:

> You need to change the .env file with the PORT you want to use.
If you want to execute in ***macvlan*** mode then you need to fill IP_ADDR also.

* Changes to compose file:
  
> Change the volume bindings for your file system like:

```
    volumes:
      - /var/docker/usr/local/nut/titledb:/opt/nut/titledb
      - /var/docker/usr/local/nut/titles:/opt/nut/titles
      - /var/docker/usr/local/nut/NSZ_files:/opt/nut/scan
```

> You can use docker volumes for `titledb` or `titles` but you need to use a volume binding for `scan` folder.

### Prerequisites **( only for macvlan mode )**

If you already have a macvlan network you need to change `pub_net` in your `docker-compose.yml` file to the macvlan network name you use:

```
networks:
  pub_net:
    external:
      name: pub_net --> change this to your macvlan name
```

Otherwise you need to create a macvlan network for your docker like this:

```
docker network create -d macvlan \
--subnet=192.168.1.0/24 \
--gateway=192.168.1.1 \
-o parent=eth0 pub_net
```

## Usage:

### Host mode:

This is the simpler one. Just execute this command in the directory where your files are:

`docker-compose up -f docker-compose-host.yml -d`

It will create your container and expose the port. You can access it with `http://<host_addr>:<port>`

### Macvlan mode:

Execute this command in the directory where your files are:

`docker-compose up -d`

It will create your container in your macvlan network. You could access it with the IP_ADDR you set in .env file like this:

`http://<ip_addr>:<port>`

## Tinfoil setup:

Create a new entry in Tinfoil with these settings:

```
protocol: nut
host: <IP_ADDR> or <HOST_IP>
port: <PORT> (default is 9000)
Username: <id in users.conf file>
Password: <password in users.conf file>
```

## Todo:
- Google Drive integration 
