ifndef BUILDTYPE
BUILDTYPE=dev
endif

ifndef BUILDVERSION
BUILDVERSION=latest
endif

.PHONY: docker

all: docker

docker:
	BUILDTYPE=$(BUILDTYPE) BUILDVERSION=$(BUILDVERSION) $(MAKE) -C docker all
