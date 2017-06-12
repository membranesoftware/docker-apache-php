dist: BUILDTYPE=dist
dist: BUILDNUMBER=  $(shell git log --all --oneline | wc -l | sed -e "s/[^0-9]//g")
dist: BUILDHASH=  $(shell git show-ref -s heads/master | cut -b -8)
dist: BUILDVERSION=$(BUILDNUMBER)-$(BUILDHASH)

ifndef BUILDTYPE
BUILDTYPE=dev
endif

ifndef BUILDVERSION
BUILDVERSION=latest
endif

.PHONY: docker

all: docker

clean:
	BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker clean

docker:
	BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker all

dist: clean docker
	BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker dist

run:
	BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker run

run-bash:
	BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker run-bash

exec-bash:
	BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker exec-bash

stop:
	BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker stop
