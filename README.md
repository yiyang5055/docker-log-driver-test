

# docker-log-driver-test

### Description

I have written couple of blogs to explain the plugin and its usage -

- [Writing A Docker Log Driver Plugin - Part I](https://medium.com/@software_factotum/writing-a-docker-log-driver-plugin-7275d99d07be)
- [Writing A Docker Log Driver Plugin - Part II](https://medium.com/@software_factotum/writing-a-docker-log-driver-plugin-f94cee827a0a)



### Requirements

* Docker && Linux



### Install

```shell
git clone https://github.com/yiyang5055/docker-log-driver-test.git
cd docker-log-driver-test
make
```

check install:

```shell
docker plugin ls
ID             NAME                   DESCRIPTION             ENABLED
01c42156f5db   docker-log-driver:v1   jsonfilelog as plugin   true
```

The following example sets the log driver to `docker-log-driver` to `/etc/docker/daemon.json`.

```shell
{
  "log-driver": "docker-log-driver:v1"
}
```

restart dokcer

```shell
systemctl restart docker
```

### Run

```
 docker run alpine echo hello world
```

