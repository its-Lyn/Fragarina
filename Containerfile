# Get the GNOME base
ARG OS_SOURCE="silverblue"
ARG SOURCE_SUFFIX="-main"
ARG FEDORA_UBLUE_VERSION="41"

# BASE IMAGE
FROM ghcr.io/ublue-os/bazzite-kernel:${FEDORA_UBLUE_VERSION}
FROM ghcr.io/ublue-os/akmods-nvidia-open:bazzite-${FEDORA_UBLUE_VERSION}
FROM ghcr.io/ublue-os/akmods:bazzite-${FEDORA_UBLUE_VERSION}
FROM ghcr.io/ublue-os/akmods-extra:bazzite-${FEDORA_UBLUE_VERSION}
FROM ghcr.io/ublue-os/${OS_SOURCE}${SOURCE_SUFFIX}:${FEDORA_UBLUE_VERSION}

COPY sysfs/ /

RUN curl -Lo /usr/bin/copr https://raw.githubusercontent.com/ublue-os/COPR-command/main/copr && \
    chmod +x /usr/bin/copr && \
    curl -Lo /etc/yum.repos.d/_copr_fiftydinar-gnome-randr-rust.repo https://copr.fedorainfracloud.org/coprs/fiftydinar/gnome-randr-rust/repo/fedora-"${FEDORA_MAJOR_VERSION}"/fiftydinar-gnome-randr-rust-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_ublue-os-staging.repo https://copr.fedorainfracloud.org/coprs/ublue-os/staging/repo/fedora-"${FEDORA_MAJOR_VERSION}"/ublue-os-staging-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    curl -Lo /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-bazzite-multilib-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
    ostree container commit

COPY --from=bazzite-kernel /tmp/rpms /tmp/bazzite-rpms
RUN rpm-ostree cliwrap install-to-root / && \
    rpm-ostree override replace \
    --experimental \
        /tmp/bazzite-rpms/kernel-[0-9]*.rpm \
        /tmp/bazzite-rpms/kernel-core-*.rpm \
        /tmp/bazzite-rpms/kernel-modules-*.rpm \
        /tmp/bazzite-rpms/kernel-uki-virt-*.rpm && \
    rpm-ostree install scx-scheds && \
    systemctl enable scx && \
    sed -i "s/SCX_SCHEDULER=scx_bpfland/SCX_SCHEDULER=scx_lavd/" /etc/default/scx && \
    curl -Lo /usr/lib/sysctl.d/99-bore-scheduler.conf https://github.com/CachyOS/CachyOS-Settings/raw/master/usr/lib/sysctl.d/99-bore-scheduler.conf && \
    ostree container commit

COPY --from=akmods-nvidia-open /rpms /tmp/akmods-rpms
RUN curl -Lo /tmp/nvidia-install.sh https://raw.githubusercontent.com/ublue-os/hwe/main/nvidia-install.sh && \
    chmod +x /tmp/nvidia-install.sh && \
    FEDORA_MAJOR_VERSION=${FEDORA_MAJOR_VERSION} IMAGE_NAME="${SOURCE_IMAGE}${SOURCE_SUFFIX}" /tmp/nvidia-install.sh && \
    rm -f /usr/share/vulkan/icd.d/nouveau_icd.*.json && \
    ostree container commit

COPY scripts/intramfs.sh /tmp/intramfs.sh
RUN tmp/intramfs.sh

COPY scripts/code.sh /tmp/code.sh
RUN tmp/code.sh

RUN rpm-ostree install \
    distrobox \
    gnome-tweaks \
    fastfetch \
    podman \
    steam-devices 