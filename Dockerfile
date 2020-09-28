ARG BASE_DOCKER_IMAGE
ARG GENERATOR_DOCKER_IMAGE
ARG YAJSV_VERSION=v1.3.0
FROM ${GENERATOR_DOCKER_IMAGE} AS openapi-generator

FROM ${BASE_DOCKER_IMAGE} AS downloader
ARG YAJSV_VERSION
RUN apk add --no-cache \
        curl \
    && curl -o "/yajsv" -SL "https://github.com/neilpa/yajsv/releases/download/${YAJSV_VERSION}/yajsv.linux.amd64" \
    && chmod 755 "/yajsv"

FROM ${BASE_DOCKER_IMAGE} AS generator
RUN apk add --no-cache \
        bash \
        jq \
        moreutils \
        openjdk8-jre-base
COPY --from=openapi-generator /opt/openapi-generator /opt/openapi-generator
COPY --from=downloader /yajsv /usr/local/bin/yajsv
COPY docker/openapi-generator /usr/local/bin/
RUN mkdir -p /opt/openapi-generator/generator/bin /opt/openapi-generator/generator/config /opt/openapi-generator/generator/overwrite /opt/openapi-generator/generator/templates
ENTRYPOINT ["/usr/local/bin/openapi-generator"]
