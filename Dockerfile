FROM drupal:latest

RUN apt-get update && apt-get install -y \
	curl \
	mariadb-client \
	vim \
	wget

RUN rm -rf /opt/drupal/*

COPY ./ /opt/drupal

RUN chown -R www-data:www-data web/sites web/modules web/themes
