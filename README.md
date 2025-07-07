# Hamclock Docker

"HamClock is a kiosk-style application that provides real time space weather, radio propagation models, operating events and other information particularly useful to the radio amateur." (Source: Hamclock Website)

This image can be run as an arbitrary user and group. The settings are saved in `/hamclock/.hamclock` in the container so it's recommended to mount a volume there to persist the settings.

See [https://www.clearskyinstitute.com/ham/HamClock/](https://www.clearskyinstitute.com/ham/HamClock/) for more information and HamClock specific documentation.

This image is based on `https://github.com/zeidlos/hamclock-docker` and `https://github.com/ChrisRomp/hamclock-docker`.

# Usage
The `DISPLAY_RES` environment variable is used to select the resolution of HamClock. Valid options are ``800x480``, ``1600x960``, ``2400x1440``, and ``3200x1920``. The default value is ``1600x960``.

## Docker Run
1. Run Hamclock using `docker run --user 63058:63058 --name hamclock -e DISPLAY_RES=<your prefered resolution> -d -p 8081:8081 -p 8080:8080 --volume ./data:/hamclock/.hamclock ghcr.io/haxwithaxe/hamclock`. ``63058`` is just a random number you can use anything or omit the `--user` option to run as ``root``. While the user can be random it must be consistent between runs.
2. Go to [http://localhost:8081/live.html](http://localhost:8081/live.html).

## Docker Compose Example
```yaml
services:
  hamclock:
    image: ghcr.io/haxwithaxe/hamclock:latest
    name: hamclock
    user: 63058:63058
    environment:
      DISPLAY_RES: 1600x960
    volumes:
      - ./data:/hamclock/.hamclock
    ports:
      - 8080:8080
      - 8081:8081
    restart: unless-stopped
```

## Build
```sh
docker build --tag hamclock:latest .
```

``Dockerfile-CI`` is used to automatically build images with GitHub Actions. It expects a different environment than ``Dockerfile`` and should be ignored.
