# static
NAME=$(shell basename ${CURDIR})
ROOT=../..
DOCKERFILE=$(CURDIR)/Dockerfile

build: Dockerfile
	DOCKERFILE=${DOCKERFILE} GENERATOR_DOCKER_IMAGE_GENERATOR=-${NAME} $(MAKE) --directory ${ROOT} build

Dockerfile: runtime
	$(MAKE) --makefile ${MAKEFILE} --always-make Dockerfile

runtime:
	$(MAKE) --makefile ${MAKEFILE} --directory ${RUNTIME} --always-make Dockerfile
