VERSION = $(shell git describe --tags --dirty)
DOCKER_ORG ?= 127.0.0.1:5000/carezkh/sanlock-daemon
ifeq ($(patsubst %dirty,,$(lastword $(VERSION))),)
DOCKER_TAG = $(VERSION)-$(shell git diff HEAD | sha1sum | awk '{ print $$1 }')
else
DOCKER_TAG = $(VERSION)
endif

build:
	docker build -f Dockerfile -t $(DOCKER_ORG):$(DOCKER_TAG) .

push:
	docker push $(DOCKER_ORG):$(DOCKER_TAG)
