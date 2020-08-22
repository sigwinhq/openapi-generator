ifndef DOCKER_IMAGE_NAME
DOCKER_IMAGE_NAME=dkarlovi/openapi-generator
endif
ifndef DOCKER_IMAGE_TAG
DOCKER_IMAGE_TAG=latest
endif

ifndef DOCKERFILE
DOCKERFILE=Dockerfile
endif

MAKEFILE=../../Makefile
BASE_DOCKER_IMAGE=alpine:3.12
GENERATOR_DOCKER_IMAGE=openapitools/openapi-generator-cli:latest

SUBDIRS := $(wildcard generators/*/.)
build-all: $(SUBDIRS)
$(SUBDIRS):
	MAKEFILE=${MAKEFILE} $(MAKE) --directory ${@} build
.PHONY: all $(SUBDIRS)

build:
	docker build --build-arg BASE_DOCKER_IMAGE=${BASE_DOCKER_IMAGE} --build-arg GENERATOR_DOCKER_IMAGE=${GENERATOR_DOCKER_IMAGE} --tag ${DOCKER_IMAGE_NAME}${GENERATOR_DOCKER_IMAGE_GENERATOR}:${DOCKER_IMAGE_TAG} --file ${DOCKERFILE} .

clean:
	rm --force generators/*/Dockerfile runtimes/*/Dockerfile

Dockerfile:
	cpp -o Dockerfile Dockerfile.in -P -nostdinc
