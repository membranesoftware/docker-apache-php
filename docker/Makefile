DOCKERNAME=docker-apache-php

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
	docker run -d --name=$(DOCKERNAME)_$(BUILDVERSION) $(DOCKERNAME):$(BUILDVERSION);

run-bash:
	docker run -it --name=$(DOCKERNAME)_$(BUILDVERSION) $(DOCKERNAME):$(BUILDVERSION) bash

exec-bash:
	docker exec -it $(DOCKERNAME)_$(BUILDVERSION) bash

stop: CONTAINERID=$(shell docker ps -a -q -f name=$(DOCKERNAME))
stop:
	if [ ! -z "$(CONTAINERID)" ]; then docker stop -t 1 $(CONTAINERID); docker rm $(CONTAINERID); fi
