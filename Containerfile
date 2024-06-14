# Get the GNOME base
ARG OS_SOURCE="silverblue"

ARG SOURCE_SUFFIX="-nvidia"

# Fedora 40 because it's stable.
ARG FEDORA_UBLUE_VERSION="40"

# BASE IMAGE
FROM ghcr.io/ublue-os/${OS_SOURCE}${SOURCE_SUFFIX}:${FEDORA_UBLUE_VERSION}

COPY sysfs/ /
COPY scripts/00-delete.sh /tmp/00-delete.sh

RUN rpm-ostree cliwrap install-to-root /