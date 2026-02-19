# Win7-on-Termux (Manager v4)

A portable and resilient environment for running Windows 7 on Android devices using Termux and QEMU.  
This project automates setup, hardware optimization, and management of an x86_64 virtual machine on ARM64 architecture.

---

## Features

- **Dynamic Resource Allocation**
  Automatically assigns 40% of available RAM and (Total CPU Cores - 1) to the VM.

- **Storage Protection**
  Uses symbolic linking to store the QCOW2 image in `/sdcard`, preventing data loss if Termux is removed.

- **Auto Installer**
  Detects and installs missing dependencies such as QEMU and X11 on first run.

- **Resilient Environment**
  Clears ghost QEMU instances before launching the VM.

---

## Prerequisites

1. Termux (Latest version from F-Droid or GitHub)
2. VNC Viewer (RealVNC, bVNC, etc.)
3. Windows 7 `.qcow2` virtual disk image
4. Minimum 20GB free internal storage

   The provided 7.16GB QCOW2 image is dynamically allocated.
   During operation, it may expand up to 16GB or more.
   Insufficient storage may result in VM failure or data corruption.

---

## Installation & Usage

### 1. Clone the Repository

```bash
pkg update && pkg upgrade
pkg install git
git clone https://github.com/myselfkshitiz/Win7-on-termux
cd Win7-on-termux
```

---

### 2. Prepare the Image

You must provide your own Windows 7 virtual disk image.

- Source: Download `win7_portable.qcow2`
- Placement: Move it to:

```
/sdcard/win7_portable.qcow2
```

---

### 3. Run the Manager

```bash
bash win7_manager.sh
```

---

### 4. Connect to Windows

Open your VNC Viewer and connect to:

```
Address: 127.0.0.1:5900
Password: (If set inside your image)
```

---

## Technical Architecture

### Phase 1: Storage Mapping
Uses `ln -sf` to map the QCOW2 file from `/sdcard` to the local project directory.

### Phase 2: Hardware Calculation
- Detects CPU cores using `nproc`
- Detects RAM using `free -m`
- Allocates approximately 40% of total RAM

Example:
On a 12GB device → ~4.5GB allocated to VM

### Phase 3: Emulation Layer

Runs using:

- CPU: `qemu64` (multi-core)
- VGA: Cirrus / VMVGA (VNC compatible)
- Network: User-mode networking

---

## Disclaimer

This project is for educational purposes only.

Performance depends heavily on device hardware.  
Ensure you legally own the Windows image you use.
