[![logo](https://raw.githubusercontent.com/ildeon/docker-rpi-transmission/master/logo.png)](https://transmissionbt.com/)

# transmission for Raspberry pi. (tested on rpi 2 B)
> This docker image is installing transmission on your raspberry pi.

# How to run it
```
docker create --name transmission-data \
              -v /etc/localtime:/etc/localtime:ro \
              -v <path to config>:/config \
              -v <path to download>:/downloads \
              ildeon7/rpi-transmission /bin/true

docker run -d -p 9091:9091 --volumes-from transmission-data --restart=always ildeon7/rpi-transmission -v <password> -u <user>
```
