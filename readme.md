## Docker image for Laravel

This image is based on the official PHP docker image, and uses PHP 7.

### Usage

Create a `Dockerfile` at the root of your project:
```
FROM petecoop/laravel
```

To build run:
```
docker build -t myapp .
```

This will build and install composer packages. composer will only run install if there is no `vendor` folder present, and will only re-run if the `composer.lock` has changed.


Run:
```
docker run -d -v .:/var/www/html -p 8080:80 myapp
```

Will now be running on port 8080 with the local directory mounted as a volume, so changes will be shown immediately.