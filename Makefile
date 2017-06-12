BUNDLETARGETS=www.tar.gz

dist: BUILDTYPE=dist
dist: BUILDNUMBER=  $(shell git log --all --oneline | wc -l | sed -e "s/[^0-9]//g")
dist: BUILDHASH=  $(shell git show-ref -s heads/master | cut -b -8)
dist: BUILDVERSION=$(BUILDNUMBER)-$(BUILDHASH)

BASEPATH=$(PWD)

ifndef BUILDTYPE
BUILDTYPE=normal
endif

ifndef BUILDVERSION
BUILDVERSION=latest
endif

.PHONY: docker

all: docker

clean:
	BASEPATH=$(BASEPATH) BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker clean
	rm -f $(BUNDLETARGETS)

docker: $(BUNDLETARGETS)
	cp -v $(BUNDLETARGETS) docker
	BASEPATH=$(BASEPATH) BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker all
	rm -f $(BUNDLETARGETS)

dist: clean docker
	BASEPATH=$(BASEPATH) BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker dist

run:
	BASEPATH=$(BASEPATH) BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker run

run-bash:
	BASEPATH=$(BASEPATH) BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker run-bash

exec-bash:
	BASEPATH=$(BASEPATH) BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker exec-bash

stop:
	BASEPATH=$(BASEPATH) BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker stop

www.tar.gz:
	tar czf $@ www
