# Skizze, im Gast ausführen. FREMD = die jeweils andere Architektur:
# arm64-Gast (Mac/UTM): FREMD=amd64, QEMU=qemu-x86_64
# amd64-Gast (Windows/VirtualBox): FREMD=arm64, QEMU=qemu-aarch64
FREMD=amd64
QEMU=qemu-x86_64

sudo apt install -y qemu-user busybox-static
sudo dpkg --add-architecture $FREMD
sudo apt update
apt download busybox-static:$FREMD
dpkg-deb -x busybox-static_*_$FREMD.deb fremd

file /bin/busybox fremd/bin/busybox
$QEMU fremd/bin/busybox uname -m

SCHLEIFE='i=0; while [ $i -lt 2000000 ]; do i=$((i+1)); done'
time busybox sh -c "$SCHLEIFE"
time $QEMU fremd/bin/busybox sh -c "$SCHLEIFE"
