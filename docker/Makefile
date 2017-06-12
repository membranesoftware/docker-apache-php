DOCKERNAME=docker-apache-php
LISTENPORT=8080

ifndef BUILDTYPE
BUILDTYPE=normal
endif

ifndef BUILDVERSION
BUILDVERSION=latest
endif

DOCKER_NETWORK_OPTS=-p $(LISTENPORT):80

DOCKER_VOLUME_OPTS=
ifeq ($(BUILDTYPE), dev)
DOCKER_VOLUME_OPTS=-v $(BASEPATH)/docker/www:/var/www/html
endif

.PHONY: docker volumes

all: docker

docker:
	@echo "Executing build type: $(BUILDTYPE)"
	docker build -t $(DOCKERNAME):$(BUILDVERSION) .

dist: docker
	docker save -o $(DOCKERNAME).docker $(DOCKERNAME):$(BUILDVERSION)

clean:
	rm -f *.docker *.tar.gz

volumes:
	if [ "$(BUILDTYPE)" = "dev" -a ! -d www ]; then mkdir www && chmod 755 www; fi;

run: volumes
	docker run -d $(DOCKER_NETWORK_OPTS) $(DOCKER_VOLUME_OPTS) --name=$(DOCKERNAME)_$(BUILDVERSION) $(DOCKERNAME):$(BUILDVERSION)

run-bash: volumes
	docker run -it $(DOCKER_NETWORK_OPTS) $(DOCKER_VOLUME_OPTS) --name=$(DOCKERNAME)_$(BUILDVERSION) $(DOCKERNAME):$(BUILDVERSION) bash

exec-bash:
	docker exec -it $(DOCKERNAME)_$(BUILDVERSION) bash

stop: CONTAINERID=$(shell docker ps -a -q -f name=$(DOCKERNAME))
stop:
	if [ ! -z "$(CONTAINERID)" ]; then docker stop -t 1 $(CONTAINERID); docker rm $(CONTAINERID); fi
