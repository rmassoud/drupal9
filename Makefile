APP_ROOT=$(CURDIR)/web
DRUSH=$(CURDIR)/bin/drush -r $(APP_ROOT)
DOCKER_REPO=303536629688.dkr.ecr.ap-southeast-2.amazonaws.com/drupal9

.DEFAULT_GOAL := help

help:
	@echo "See the README.md for available options"

init: composer

config-import:
	$(DRUSH) config-import -y

config-export:
	$(DRUSH) config-export -y

deploy:
	composer install --prefer-dist --no-progress --no-suggest --optimize-autoloader
	$(DRUSH) deploy -y

aws-ecr-login:
	aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin $(DOCKER_REPO)

build-docker:
	docker buildx build --platform=linux/amd64 -t drupal9:latest .

push-docker:
	docker tag drupal9:latest $(DOCKER_REPO):latest
	docker push $(DOCKER_REPO):latest

release-docker: build-docker aws-ecr-login push-docker

start:
	docker run -it -p 8080:80 drupal9:latest
