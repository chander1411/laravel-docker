ARG PHP_VERSION=8.3
FROM php:${PHP_VERSION}-fpm

ENV DEBIAN_FRONTEND=noninteractive
ENV COMPOSER_ALLOW_SUPERUSER=1

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        git curl zip unzip ca-certificates gnupg \
        libzip-dev libpng-dev libjpeg-dev libwebp-dev libfreetype6-dev \
        libonig-dev libicu-dev libpq-dev libxml2-dev; \
    docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype; \
    docker-php-ext-install -j"$(nproc)" \
        pdo_mysql pdo_pgsql mysqli gd zip intl bcmath pcntl exif opcache mbstring xml; \
    pecl install redis; \
    docker-php-ext-enable redis; \
    rm -rf /var/lib/apt/lists/* /tmp/pear

# Node.js (npm run build / npm run dev de Laravel + Vite)
ARG NODE_MAJOR=22
RUN set -eux; \
    curl -fsSL https://deb.nodesource.com/setup_${NODE_MAJOR}.x | bash -; \
    apt-get install -y --no-install-recommends nodejs; \
    rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY php/php.ini /usr/local/etc/php/conf.d/zz-app.ini
COPY php/opcache.ini /usr/local/etc/php/conf.d/zz-opcache.ini

WORKDIR /var/www/html
