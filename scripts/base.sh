#!/usr/bin/env bash

# Force update packages with often cause build problems
rpm-ostree override replace \
--experimental \
--from repo=updates \
vulkan-loader \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
alsa-lib \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
gnutls \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
glib2 \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
nspr \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
nss \
nss-softokn \
nss-softokn-freebl \
nss-sysinit \
nss-util \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
atk \
at-spi2-atk \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libaom \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
gstreamer1 \
gstreamer1-plugins-base \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libdecor \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libtirpc \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libuuid \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libblkid \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libmount \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
cups-libs \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libinput \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libopenmpt \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
llvm-libs \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
zlib-ng-compat \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
fontconfig \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
pciutils-libs \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libdrm \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
cpp \
libatomic \
libgcc \
libgfortran \
libgomp \
libobjc \
libstdc++ \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libX11 \
libX11-common \
libX11-xcb \
|| true && \
rpm-ostree override replace \
--experimental \
--from repo=updates \
libv4l \
|| true