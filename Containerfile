# Get the GNOME base
ARG OS_SOURCE="silverblue"

ARG SOURCE_SUFFIX="-nvidia"

# Fedora 41 because it's stable.
ARG FEDORA_UBLUE_VERSION="41"

# BASE IMAGE
FROM ghcr.io/ublue-os/${OS_SOURCE}${SOURCE_SUFFIX}:${FEDORA_UBLUE_VERSION}

COPY scripts/00-delete.sh /tmp/00-delete.sh

# Add the 6.6 kernel COPR
RUN dnf5 copr enable kwizart/kernel-longterm-6.6 -y

# Install said kernel
RUN rpm-ostree cliwrap install-to-root /
RUN rpm-ostree override remove kernel kernel-{core,modules,modules-extra} \
    --install kernel-longterm \
    --install kernel-longterm-core \
    --install kernel-longterm-modules \
    --install kernel-longterm-modules-extra

# Remove default firefox
RUN rpm-ostree override remove \
    firefox \
    firefox-langpacks \

RUN rpm-ostree install \
    fish \
    gnome-tweaks \