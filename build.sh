#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

systemctl enable podman.socket



# Start of Virtualization stack

echo "Started Installing The Virtualization Stack"
echo "Installing LibVirt & tools"
rpm-ostree install libvirt-client \
  qemu-kvm \
  virt-install \
  virt-manager \
  virt-viewer \
  swtpm \
  tuned \
  bridge-utils
echo "Making sure the LibVirt Monolithic Service & Socket is Disabled"
systemctl disable libvirt.service
systemctl disable libvirt.socket
echo "Enabling the LibVirt Dynamic Services & Sockets"
for drv in qemu network nodedev nwfilter secret storage
do
  systemctl enable virt${drv}d.service
  systemctl enable virt${drv}d{,-ro,-admin}.socket
done
echo "Finished Installing The Virtualization Stack"

# End of Virtualization stack

# Start of Sunshine

echo "Started Installing Sunshine"
echo "Grabbing The lizardbyte Sunshine COPR"
curl -Lo /etc/yum.repos.d/lizardbyte-Sunshine-fedora-$RELEASE.repo https://copr.fedorainfracloud.org/coprs/lizardbyte/Sunshine/repo/fedora-$RELEASE/lizardbyte-Sunshine-fedora-$RELEASE.repo
sed -i 's@gpgcheck=1@gpgcheck=0@g' /etc/yum.repos.d/lizardbyte-Sunshine-fedora-$RELEASE.repo  #hack to just to get this to build NEED TO FIX LATER
echo "Installing The sunshine Package"
rpm-ostree install sunshine
echo "Removing The Lizardbyte sunshine COPR"
rm /etc/yum.repos.d/lizardbyte-Sunshine-fedora-$RELEASE.repo

# End of Sunshine
