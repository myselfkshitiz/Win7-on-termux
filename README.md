# Win7-on-Termux (Manager v4)

Enterprise-Style Portable Virtualization Environment for Running Windows 7 on Android (ARM64) Using Termux and QEMU

---

## Overview

Win7-on-Termux (Manager v4) is a structured virtualization management environment designed to run a Windows 7 x86_64 virtual machine on ARM64 Android devices via QEMU.

The project focuses on:

- Automation
- Stability
- Resource optimization
- Storage safety
- Portability
- Controlled system scaling

This repository does not distribute Windows binaries. It provides a management framework for users who legally possess their own Windows installation media.

---

## Core Capabilities

### 1. Dynamic Resource Management

The manager script automatically:

- Detects total system RAM
- Detects total CPU cores
- Allocates 40% of RAM to the VM
- Allocates (Total Cores - 1)

This ensures Android host stability while maximizing VM performance.

---

### 2. Storage Isolation & Protection

The QCOW2 virtual disk is stored in:

/sdcard/

A symbolic link maps it into the project directory.

Benefits:

- Survives Termux uninstall/reset
- Prevents accidental image deletion
- Improves data safety

---

### 3. Automated Dependency Provisioning

On first execution, the script:

- Checks for required packages
- Installs missing dependencies (QEMU, supporting libraries)
- Ensures a consistent runtime environment

---

### 4. Process Hygiene

Before launching the VM, the manager:

- Detects ghost QEMU processes
- Terminates conflicting instances
- Prevents VNC/socket port conflicts

---

## System Requirements

- Android ARM64 device
- Termux (F-Droid recommended)
- VNC Viewer application
- Windows 7 x64 ISO or QCOW2 image
- Minimum 20GB free internal storage

Storage Note:

Although the base QCOW2 file is ~7.16GB, it is dynamically allocated and may expand up to 16GB or more during usage.

Insufficient storage may cause VM failure or data corruption.

---

## ISO Source (Development Reference)

During development and testing, the ISO used was:

Archive Page:
https://archive.org/details/win-7-pro-sp1-english

Direct ISO:
https://archive.org/download/win-7-pro-sp1-english/Win7_Pro_SP1_English_x64.iso

This reference is provided for transparency only.

Users are responsible for ensuring legal eligibility to download and use Microsoft software in their jurisdiction.

---

## Build Methodology (ISO to QCOW2)

This environment was built from a clean ISO installation.

### Phase 1 — Disk Creation

qemu-img create -f qcow2 win7.qcow2 20G

QCOW2 was selected because:

- It is thin-provisioned
- Expands only as data is written
- Efficient for mobile storage constraints

---

### Phase 2 — ISO Installation

ISO mounted using:

- -cdrom
- -boot d

USB controller added:

-device usb-ehci

Display method switched to:

-vnc :1

This avoided Termux-X11 socket conflicts.

---

### Phase 3 — Windows Setup Loop Resolution

Encountered known Windows 7 + QEMU compatibility issue:

"The computer restarted unexpectedly."

Resolution:

Shift + F10  
Run regedit  
Navigate to:

HKEY_LOCAL_MACHINE\SYSTEM\Setup\Status\ChildCompletion

Change:

setup.exe = 1 → 3

This forces setup completion.

---

### Phase 4 — Optimization

Applied performance improvements:

- Switched to Windows Classic theme
- Disabled Windows Search Indexer
- Disabled Windows Updates
- Upgraded CPU model to:
  -cpu core2duo
- Enabled disk cache:
  -cache=writeback

---

### Phase 5 — Automation & Scaling

Converted manual configuration into automated manager system:

- QCOW2 moved to /sdcard/
- RAM/CPU dynamically calculated
- Optional disk resize supported (20GB → 64GB)

---

## Legal & Compliance Statement

1. This repository does NOT distribute:
   - Windows ISO files
   - Windows product keys
   - Activation tools
   - Cracks or bypass utilities

2. No product key was used, distributed, embedded, or provided within this project.

3. The virtual environment is provided for:
   - Educational purposes
   - Virtualization research
   - System experimentation

4. Users are solely responsible for:
   - Licensing compliance
   - Activation status
   - Legal use of Microsoft software

5. The author assumes no liability for:
   - License violations
   - Misuse
   - Data loss
   - Hardware damage

---

## Security & Transparency

- The QCOW2 image is built from a clean ISO installation.
- No external binaries are injected.
- No hidden activation scripts exist.
- No remote access services are embedded.
- No telemetry modifications were performed beyond standard Windows configuration changes.

If desired, users may reproduce the build process manually using the ISO and steps documented above.

---

## Architecture Summary

Termux = Host Runtime Environment  
QEMU = Virtualization Engine  
VNC Viewer = Display Interface  
win7_manager.sh = Control Layer  

---

## Limitations

- Emulation performance depends heavily on device hardware.
- Windows 7 is legacy software and no longer supported by Microsoft.
- ARM64 → x86_64 emulation is CPU intensive.
- Not suitable for gaming or heavy GPU workloads.

---

## Disclaimer

This project is provided “as-is” without warranty of any kind.

Use at your own risk.

Ensure you comply with all applicable software licensing laws in your country.
