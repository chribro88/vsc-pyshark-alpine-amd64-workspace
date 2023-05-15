#-------------------------------------------------------------------------------------------------------------
# vsc-pyshark-alpine-amd64-workspace
#-------------------------------------------------------------------------------------------------------------
ARG REGISTRY_HOST=
ARG REGISTRY_USERNAME=

ARG BASE_VERSION=3.18

FROM ${REGISTRY_HOST}${REGISTRY_USERNAME}vsc-alpine-amd64-workspace:${BASE_VERSION}

ARG USERNAME=vsc

RUN apk --update --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing --repository http://dl-cdn.alpinelinux.org/alpine/edge/main add \
    # tshark & setcap
    tshark libcap

# set the permissions, non-root user
# https://wiki.wireshark.org/CaptureSetup/CapturePrivileges
RUN chown root:wireshark /usr/bin/dumpcap \
    && chmod o-rx /usr/bin/dumpcap \
    && setcap cap_net_raw,cap_net_admin+eip /usr/bin/dumpcap \
    && usermod -a -G wireshark $USERNAME

# copy over the conda environment setup script
COPY --chown=1000 .devcontainer/postCreateCommand.sh \
     .devcontainer/environment.yml* /tmp/conda-tmp/

RUN chmod +x /tmp/conda-tmp/postCreateCommand.sh

# Clean up
RUN rm -rf /var/cache/apk/*

# Forward ports
EXPOSE 5000
