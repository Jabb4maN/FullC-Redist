# FullCppRedist
AIO Installer for all latest Microsoft Visual C++ Redistributable
## Overview

Tired of bloated installers? This project offers a streamlined All-in-One (AIO) repack of the latest Microsoft Visual C++ Redistributable Runtimes. We've significantly reduced the installer's footprint by removing unnecessary components from the original setups.

### How it Works

The installation is handled by a discreet Windows command script that runs silently in the background. Before anything is installed, it intelligently scans and removes any problematic or older Visual C++ Runtimes, including those from original EXE or MSI packages.

Need to clean up? Our uninstallation script can remove all detected VC++ runtimes (excluding Universal CRT), so all you need is chilling.

### Compatibility

combatible with all windows os:
* windows xp
* windows Vista / 7
* windows 8/8.1
* windows 10
* windows 11

### Installation

To get started, simply:

1.  **Run `FullCppRedist.exe` as administrator.**

---

## What's Included

This repack provides a comprehensive collection of essential runtimes:

### Visual C++ Redistributables (x86/x64)

* **2005:** v8.0.50727.6229
* **2008:** v9.0.30729.7523
* **2010:** v10.0.40219.473
* **2012:** v11.0.61135.400
* **2013:** v12.0.40664.0
* **2022:** The very latest version

### Visual Studio 2010 Tools for Office Runtime (x86/x64)

* **Version:** v10.0.60922

### Legacy Runtimes (x86)

* **Visual C++ 2002:** v7.0.9975.0
* **Visual C++ 2003:** v7.10.6119.0

### Visual Basic Runtimes

### Universal CRT (UCRT)

The Universal CRT is a vital component, seamlessly integrated with the VC++ 2022 redistributable. It's a built-in feature for Windows 10/11. For Windows Vista/7/8/8.1, it's typically delivered via Monthly Quality Rollups, KB3118401, or KB2999226. If you're on Windows XP, it's installed alongside the VC++ 2019 redistributable. Our repack ensures **KB3118401** is installed if UCRT isn't already present.

**Good to know:** The VC++ 2022 runtimes are fully binary compatible with VC++ 2015, 2017, and 2019. This means they cover all applications built with Visual Studio versions from 2015 through 2022.
