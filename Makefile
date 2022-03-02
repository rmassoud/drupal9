APP_ROOT=$(CURDIR)/web
DRUSH=$(CURDIR)/bin/drush -r $(APP_ROOT)
DOCKER_REPO=303536629688.dkr.ecr.ap-southeast-2.amazonaws.com/drupal9

.DEFAULT_GOAL := help

help:
	@echo "See the README.md for available options"

init:
	composer validate --strict
	composer install --prefer-dist --no-progress --no-suggest --optimize-autoloader

test:
	echo "Linting repository"

build:
	docker build -t drupal9:latest .

start:
	docker run -it -p 8080:80 drupal9:latest
