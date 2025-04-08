FROM php:8.3-fpm-alpine

RUN apk add --no-cache curl git build-base zlib-dev oniguruma-dev autoconf bash

RUN apk add --no-cache \
        && docker-php-ext-install pdo mysqli pdo_mysql

ARG PUID=1000
ARG PGID=1000
RUN apk --no-cache add shadow && \
    groupmod -o -g ${PGID} www-data && \
    usermod -o -u ${PUID} -g www-data www-data

RUN apk add --update linux-headers

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN chown www-data:www-data /var/www
COPY --chown=www-data:www-data ./ /var/www
WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000
