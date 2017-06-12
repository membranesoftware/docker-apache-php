DOCKERNAME=docker-apache-php
LISTENPORT=8080

DOCKER_NETWORK_OPTS=-p $(LISTENPORT):80

.PHONY: docker

all: docker

docker:
	@echo "Executing build type: $(BUILDTYPE)"
	docker build -t $(DOCKERNAME):$(BUILDVERSION) .

dist: docker
	docker save -o $(DOCKERNAME).docker $(DOCKERNAME):$(BUILDVERSION)

clean:
	rm -f *.docker

run:
	docker run -d $(DOCKER_NETWORK_OPTS) --name=$(DOCKERNAME)_$(BUILDVERSION) $(DOCKERNAME):$(BUILDVERSION);

run-bash:
	docker run -it $(DOCKER_NETWORK_OPTS) --name=$(DOCKERNAME)_$(BUILDVERSION) $(DOCKERNAME):$(BUILDVERSION) bash

exec-bash:
	docker exec -it $(DOCKERNAME)_$(BUILDVERSION) bash

stop: CONTAINERID=$(shell docker ps -a -q -f name=$(DOCKERNAME))
stop:
	if [ ! -z "$(CONTAINERID)" ]; then docker stop -t 1 $(CONTAINERID); docker rm $(CONTAINERID); fi
