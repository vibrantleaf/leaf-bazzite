#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


rpm-ostree install libvirt-client \
  qemu-kvm \
  virt-install \
  virt-manager \
  virt-viewer \
  swtpm \
  tuned \
  bridge-utils

systemctl enable podman.socket
