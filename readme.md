## Docker image for Laravel

This image is based on the official PHP docker image, and uses PHP 7.

### Usage

Create a `Dockerfile` at the root of your project:
```
FROM petecoop/laravel:onbuild
```

To build run:
```
docker build -t myapp .
```

This will build and install composer packages. If no changes to composer.json or composer.lock are made, then the next time this is ran it will skip installing composer packages.


Run:
```
docker run -d -v .:/var/www/html -p 8080:80 myapp
```

Will now be running on port 8080 with the local directory mounted as a volume, so changes will be shown immediately.