# Im Gast ausführen: bash emulation.sh
# Misst dieselbe Schleife mit busybox für die ISA des Gasts und mit busybox für eine fremde ISA unter Emulation.
set -e

case "$(uname -m)" in
  aarch64) FREMD=amd64; QEMU=qemu-x86_64 ;;
  x86_64)  FREMD=arm64; QEMU=qemu-aarch64 ;;
esac

sudo apt install -y qemu-user busybox-static
sudo dpkg --add-architecture $FREMD
sudo apt update
apt download busybox-static:$FREMD
dpkg-deb -x busybox-static_*_$FREMD.deb fremd

file /bin/busybox fremd/bin/busybox
$QEMU fremd/bin/busybox uname -m

SCHLEIFE='i=0; while [ $i -lt 2000000 ]; do i=$((i+1)); done'
echo "nativ:"
time busybox sh -c "$SCHLEIFE"
echo "emuliert:"
time $QEMU fremd/bin/busybox sh -c "$SCHLEIFE"
