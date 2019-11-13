FROM php:cli-alpine

RUN apk add icu-dev

RUN docker-php-ext-install opcache intl gd pgsql pdo pdo_pgsql
RUN docker-php-ext-enable opcache intl gd pgsql pdo pdo_pgsql

ADD config/opcache.ini $PHP_INI_DIR/conf.d/

WORKDIR /usr/src/ttrss

RUN curl -o ttrss.tar.gz https://git.tt-rss.org/fox/tt-rss/archive/19.2.tar.gz \
	&& tar --strip-components=1 -xzf ttrss.tar.gz \
	&& rm -f ttrss.tar.gz

USER 9004:9004

CMD [ "php", "./update_daemon2.php"]
