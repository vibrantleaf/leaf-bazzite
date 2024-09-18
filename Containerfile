ARG SOURCE_IMAGE="bazzite"
ARG SOURCE_SUFFIX="-gnome"
ARG SOURCE_TAG="latest"

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

COPY build.sh /tmp/build.sh

COPY system_files/usr /usr

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit

RUN rm -rf /var/cache/* && \
    rm -rf /var/tmp/* && \
    /usr/libexec/containerbuild/cleanup.sh && \
    ostree container commit
