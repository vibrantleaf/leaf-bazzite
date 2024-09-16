# vim: set ft=make :
set-virtualization-kernel-options-amd ACTION="":
    #!/usr/bin/bash
   rpm-ostree kargs \
      --append-if-missing="amd_iommu=on"  \
      --append-if-missing="iommu=pt" \
      --append-if-missing="kvm_amd.nested=1"  \
      --append-if-missing="vfio_iommu_type1.allow_unsafe_interrupts=1"  \
      --append-if-missing="kvm.ignore_msrs=1" \
      --append-if-missing="default_huepagesz=1G" \
      --append-if-missing="hugepagesz=1G"

set-virtualization-kernel-options-intel ACTION="":
    #!/usr/bin/bash
   rpm-ostree kargs \
      --append-if-missing="intel_iommu=on"  \
      --append-if-missing="iommu=pt" \
      --append-if-missing="kvm_intel.nested=1"  \
      --append-if-missing="vfio_iommu_type1.allow_unsafe_interrupts=1"  \
      --append-if-missing="kvm.ignore_msrs=1" \
      --append-if-missing="default_huepagesz=1G" \
      --append-if-missing="hugepagesz=1G"