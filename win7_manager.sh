#!/bin/bash

# 1. Immediate Dependency Check (The Auto-Installer)
if ! command -v qemu-system-x86_64 &> /dev/null || ! command -v qemu-img &> /dev/null; then
    echo "--- Fresh Install Detected ---"
    echo "[!] Installing QEMU and core utilities..."
    pkg update -y && pkg upgrade -y
    pkg install qemu-system-x86_64-headless qemu-utils -y
    clear
fi

echo "=========================================="
echo "   🚀 WINDOWS 7 SMART LAUNCHER (v4)    "
echo "=========================================="

# 2. System Analysis
TOTAL_RAM=$(free -m | awk '/^Mem:/{print $2}')
ALLOC_RAM=$((TOTAL_RAM * 40 / 100))
[ $ALLOC_RAM -lt 2048 ] && ALLOC_RAM=2048
CORES=$(nproc)
USE_CORES=$((CORES - 1))

# 3. Path Configuration
IFILE="/sdcard/win7_portable.qcow2"
LFILE="$HOME/win7.qcow2"

if [ ! -f "$IFILE" ]; then
    echo "[✘] ERROR: win7_portable.qcow2 missing from /sdcard/"
    exit 1
fi

# 4. Storage Provisioner (Now works on fresh install)
CURRENT_SIZE=$(qemu-img info "$IFILE" | grep "virtual size" | awk '{print $3}')
echo "[i] Current Windows Disk Size: ${CURRENT_SIZE}GB"
echo "------------------------------------------"
echo "Expand storage? Enter GB (37, 50, 64) or ENTER to skip:"
read -p "Target Size: " NEW_SIZE

if [ ! -z "$NEW_SIZE" ]; then
    echo "[+] Resizing image to ${NEW_SIZE}G..."
    pkill -9 qemu-system-x86_64 > /dev/null 2>&1
    qemu-img resize "$IFILE" "${NEW_SIZE}G"
    echo "[✔] Done!"
fi

# 5. Link and Launch
ln -sf "$IFILE" "$LFILE"

echo "------------------------------------------"
echo "[✔] RAM: ${ALLOC_RAM}MB | CPU Cores: ${USE_CORES}"
echo "📡 VNC: 127.0.0.1:5901"
echo "=========================================="
echo ">>> BOOTING NOW... <<<"

qemu-system-x86_64 \
-m ${ALLOC_RAM}M \
-smp ${USE_CORES} \
-cpu core2duo \
-drive file="$LFILE",format=qcow2,if=ide,cache=writeback \
-vga std \
-device usb-ehci,id=usb -device usb-mouse,bus=usb.0 \
-vnc :1 \
-rtc base=localtime \
-net nic,model=virtio -net user \
-monitor stdio

