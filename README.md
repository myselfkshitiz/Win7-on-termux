# Win7-on-Termux (Manager v4)

Portable virtualization management framework for running Windows 7 x64 on Android (ARM64) using QEMU and Termux.

---

## Overview

Win7-on-Termux (Manager v4) provides an automated environment to deploy and manage a Windows 7 x86_64 virtual machine on ARM64 Android devices.

This repository does NOT distribute Windows binaries.  
Users must supply their own legally obtained installation media.

---

## Key Features

- Automatic RAM allocation (40% of total memory)
- Automatic CPU allocation (Total Cores - 1)
- QCOW2 stored in /sdcard/ for persistence
- Dependency auto-installation
- Automatic cleanup of conflicting QEMU processes
- Optional disk resizing support

---

## Requirements

- ARM64 Android device
- Termux (F-Droid recommended)
- VNC Viewer
- Windows 7 x64 ISO or QCOW2 image (legally obtained)
- Minimum 20GB free internal storage

Note:
QCOW2 is dynamically allocated.  
Although initial size may be ~7GB, it can expand up to 16GB or more.

---

## ISO to QCOW2 Conversion Summary

The development image was created from a clean Windows 7 Professional SP1 x64 ISO.

### Step 1 — Create Virtual Disk

qemu-img create -f qcow2 win7.qcow2 20G

QCOW2 was chosen for thin-provisioned storage efficiency.

---

### Step 2 — Install from ISO

- Mounted ISO using -cdrom
- Boot priority set using -boot d
- Added USB controller:
  -device usb-ehci
- Switched display to:
  -vnc :1

---

### Step 3 — Resolve Setup Loop

If Windows displays:
"The computer restarted unexpectedly"

Fix:

Shift + F10  
Run regedit  
Navigate to:

HKEY_LOCAL_MACHINE\SYSTEM\Setup\Status\ChildCompletion

Change:
setup.exe = 1 → 3

This forces setup completion.

---

### Step 4 — Optimization

Applied:

- Windows Classic theme
- Disabled Search Indexer
- Disabled Windows Updates
- -cpu core2duo
- -cache=writeback

---

### Step 5 — Manager Automation

Converted static install into managed environment:

- Moved QCOW2 to /sdcard/
- Automated RAM/CPU detection
- Added optional disk resize (20GB → 64GB)

---

## Legal & Distribution Policy

This repository does NOT provide:

- Windows ISO files
- QCOW2 images
- Product keys
- Activation tools
- Licensing bypass methods

No product key was used, embedded, or distributed.

Users must ensure:

- They possess valid Windows licensing
- They comply with software laws in their jurisdiction
- They have appropriate hardware and storage resources

---

## Limitations

- Windows 7 is legacy software.
- ARM64 → x86_64 emulation is CPU intensive.
- Performance depends on device specifications.
- Not intended for GPU-heavy workloads.

---

## Disclaimer

Provided for educational and research purposes only.

Use at your own risk.

The author assumes no liability for misuse, licensing violations, or data loss.
