FROM php:7.1-apache

# install php modules
RUN apt-get update && apt-get install -y --force-yes \
    freetds-dev \
    libicu-dev \
    libpq-dev \
    libmcrypt-dev \
    libpng-dev \
    git \
 && rm -r /var/lib/apt/lists/* \
 && cp -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/ \
 && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
 && docker-php-ext-install \
    gd \
    mbstring \
    mcrypt \
    pcntl \
    pdo_dblib \
    pdo_mysql \
    pdo_pgsql \
    zip

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite

COPY virtualhost.conf /etc/apache2/sites-enabled/000-default.conf
