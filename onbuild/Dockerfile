FROM petecoop/laravel

# install composer deps
ONBUILD COPY composer.json composer.json
ONBUILD COPY composer.lock composer.lock
ONBUILD RUN composer install --no-dev --prefer-dist --no-autoloader --no-scripts

ONBUILD COPY . /var/www/html

ONBUILD RUN composer dump-autoload
ONBUILD RUN php artisan optimize
