FROM php:7-apache

# install php modules
RUN apt-get update && apt-get install -y --force-yes \
    freetds-dev \
    libicu-dev \
    libpq-dev \
    libmcrypt-dev \
    git \
 && rm -r /var/lib/apt/lists/* \
 && cp -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/ \
 && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
 && docker-php-ext-install \
    mbstring \
    mcrypt \
    pdo_dblib \
    pdo_mysql \
    pdo_pgsql \
    zip \
 && cd /usr/src/php \
 && make clean

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite

COPY virtualhost.conf /etc/apache2/sites-enabled/

# install composer deps
ONBUILD COPY composer.json composer.json
ONBUILD COPY composer.lock composer.lock
ONBUILD RUN composer install --no-dev --prefer-dist --no-autoloader --no-scripts

ONBUILD COPY . /var/www/html

ONBUILD RUN composer dump-autoload
ONBUILD RUN php artisan optimize
