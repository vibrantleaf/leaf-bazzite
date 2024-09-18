# set optimal kernel options for virtualization with a AMD cpu 
unset-virtualization-kernel-options-amd:
    rpm-ostree kargs \
        --append-if-missing="amd_iommu=on"  \
        --append-if-missing="iommu=pt" \
        --append-if-missing="kvm_amd.nested=1"  \
        --append-if-missing="vfio_iommu_type1.allow_unsafe_interrupts=1"  \
        --append-if-missing="kvm.ignore_msrs=1" \
        --append-if-missing="default_huepagesz=1G" \
        --append-if-missing="hugepagesz=1G"

# set optimal kernel options for virtualization with a Intel cpu 
unset-virtualization-kernel-options-intel:
    rpm-ostree kargs \
        --append-if-missing="intel_iommu=on"  \
        --append-if-missing="iommu=pt" \
        --append-if-missing="kvm_intel.nested=1"  \
        --append-if-missing="vfio_iommu_type1.allow_unsafe_interrupts=1"  \
        --append-if-missing="kvm.ignore_msrs=1" \
        --append-if-missing="default_huepagesz=1G" \
        --append-if-missing="hugepagesz=1G"

# unset optimal kernel options for virtualization with a AMD cpu 
unset-virtualization-kernel-options-amd:
    rpm-ostree kargs \
        --delete-if-present="amd_iommu=on"  \
        --delete-if-present="iommu=pt" \
        --delete-if-present="kvm_amd.nested=1"  \
        --delete-if-present="vfio_iommu_type1.allow_unsafe_interrupts=1"  \
        --delete-if-present="kvm.ignore_msrs=1" \
        --delete-if-present="default_huepagesz=1G" \
        --delete-if-present="hugepagesz=1G"

# unset optimal kernel options for virtualization with a Intel cpu 
unset-virtualization-kernel-options-intel:
    rpm-ostree kargs \
        --delete-if-present="intel_iommu=on"  \
        --delete-if-present="iommu=pt" \
        --delete-if-present="kvm_intel.nested=1"  \
        --delete-if-present="vfio_iommu_type1.allow_unsafe_interrupts=1"  \
        --delete-if-present="kvm.ignore_msrs=1" \
        --delete-if-present="default_huepagesz=1G" \
        --delete-if-present="hugepagesz=1G"

# reinstall my vm backups from codeberg
reinstall-my-vms-backups:
    git clone https://codeberg.org/vibrantleaf/vms.git /var/tmp/vms-repo
    sudo sed -i 's@SELINUX=enforcing@SELINUX=permissive@g' /etc/selinux/config
    sed -i 's@Exec=/opt/utils/libvirt/antistartup.sh@Exec=/etc/libvirt/hooks/antistartup.sh@g' /var/tmp/vms-repo/rootfs/etc/systemd/system/antistartup.service
    cat /var/tmp/vms-repo/rootfs/etc/fstab-append | tee -a /etc/fstab
    rm -rf /var/tmp/vms-repo/rootfs/etc/{dnf,modprobe.d,modules-load.d,selinux,crontab,fstab-append}
    cp -rfv /var/tmp/vms-repo/rootfs/etc/* /etc
    cp -rfv /var/tmp/vms-repo/rootfs/opt/utils/libvirt/antistartup.sh /etc/libvirt/hooks/antistartup.sh
    cp -rfv /var/tmp/vms-repo/libvirt-xmls ~/libvirt-xmls
    cp -rfv /var/tmp/vms-repo/guest-tweaks ~/guest-tweaks
    rm -rf /var/tmp/vms-repo
