# docker-plex

Plex Media Server, in a container

[![](https://images.microbadger.com/badges/version/arbourd/plex.svg)](http://microbadger.com/images/arbourd/plex "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/arbourd/plex.svg)](http://microbadger.com/images/arbourd/plex "Get your own image badge on microbadger.com")

## Installation

Clone the repo and build it

```bash
$ git clone git@github.com:arbourd/docker-plex.git

$ docker build -t plex .
```

Or pull from Docker Hub

```bash
$ docker pull arbourd/plex
```

## Run it

```bash
$ docker run --name=plex -d -p 32400:32400 -v <config>:/plex -v <media path>:/audiovisual arbourd/plex
```

## Cavats

### Setting `allowedNetworks`

To gain access to `<ip>:32400/web` (the server) from outside the host machine locally:

* Open `Preferences.xml` in your favourite editor

```bash
$ vim <config>/Library/Application Support/Plex Media Server/Preferences.xml
```

* Add `allowedNetworks="192.168.1.0/16"` or whatever your local range / subnet are to `Preferences.xml`

### `host` mode

Running `docker run` with `--net="host"` will open up the entire hosts network stack to the container allowing `avahi` to broadcast locally.

This is necessary if you want to access Plex locally without signing in with a Plex account.

### Error: PRAGMA cache_size=4000

This seems to be a `docker-machine` issue. No fix at this time.

## Differences between this Plex container and others

* Smaller footprint
* Uses PPA to download / install Plex Media Server
* `init.sh` matches host and client GIDs
* Runs Plex Media Server as `plex` user, not `root`

## License

Public Domain
