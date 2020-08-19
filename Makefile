DOCKER_IMAGE_NAME=dkarlovi/openapi-generator
ifndef DOCKER_IMAGE_TAG
DOCKER_IMAGE_TAG=latest
endif

BASE_DOCKER_IMAGE=alpine:3.12
GENERATOR_DOCKER_IMAGE=openapitools/openapi-generator-cli:latest

build:
	docker build --build-arg BASE_DOCKER_IMAGE=${BASE_DOCKER_IMAGE} --build-arg GENERATOR_DOCKER_IMAGE=${GENERATOR_DOCKER_IMAGE} --tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} .

clean:
	
