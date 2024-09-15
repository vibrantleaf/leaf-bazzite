#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


rpm-ostree install libvirt-client qemu-kvm virt-install virt-manager virt-viewer swtpm tuned bridge-utils

rpm-ostree kargs --append-if-missing="amd_iommu=on" --append-if-missing="iommu=pt" --append-if-missing="kvm_amd.nested=1" --append-if-missing="vfio_iommu_type1.allow_unsafe_interrupts=1" --append-if-missing="kvm.ignore_msrs=1" --append-if-missing="default_huepagesz=1G" --append-if-missing="hugepagesz="1G"

systemctl enable podman.socket
