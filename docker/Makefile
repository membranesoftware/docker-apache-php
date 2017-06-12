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
