# 🛠️ Build Tools for VC++ Redist AIO Repack

---

## Overview

This guide outlines the tools and steps required to prepare the slimmed MSI packages for the Visual C++ Redistributable AIO repack. It covers the process from extracting original installers to creating the final AIO executable.

---

## Requirements

To build the AIO package, you'll need:

* **VBScript Files:** For modifying and slimming MSI files (from `dumpydooby`, modified by `ricktendo64`).
* **`WiSumInf.vbs`:** To update MSI summary information (part of Windows SDK's Windows Installer utility scripts).
* **[WiX Toolset v3](https://github.com/wixtoolset/wix3/releases/)**: For extracting later VC++ Bootstrappers (2012+) and building legacy VB/C runtime MSIs.
* **[7zSfxMod](https://github.com/chrislake/7zsfxmm)**: A modified 7z SFX module to create the final AIO executable installer.

---

## General Build Steps

1.  **Organize:** Place original executable files (`.exe`) into their respective version folders.
2.  **Extract:** Open Command Prompt as administrator in the folder and run commands to extract original redistributables.
3.  **Slim:** (Optional) Remove unneeded extracted files (keep `.msi`, `.cab`, and `.msp` for 2010). Then, run VBScript files to slim the MSI database.
4.  **Admin Install:** Perform an administrative installation of the modified MSIs to remove internal unneeded files, reducing the final archive size.

---

## WiX Tips

* **PATH Variable:** Add the WiX binaries folder to your system's `PATH` for easier command-line use.
    * **Global (Permanent):** `setx PATH "W:\GitHub\dotNetFx4xW7\BIN;%PATH%" /M`
    * **Session (Temporary):** `set "PATH=W:\GitHub\dotNetFx4xW7\BIN;%PATH%"`
* **Compression Levels:** Supported `dcl` levels for `light.exe` are `none`, `low`, `mszip`, `medium`, `high`.

---

## Specific Version Instructions

Detailed commands for **Extract**, **Modify**, and **Admin Install** are provided for each VC++ Redistributable version. Follow these steps sequentially for each package:

* **VC++ 2005**
* **VC++ 2008**
* **VC++ 2010**
* **VC++ 2012**
* **VC++ 2013**
* **VC++ 2015-2022**
* **VSTOR 2010**

*(Specific commands for each version are omitted here for brevity as they are lengthy and self-explanatory in your original document, but would be included in the actual README.)*

---

## Legacy Runtimes (VB/C++)

1.  **Download:** Obtain `VBCRun.7z` from the provided link and extract its contents.
2.  **Build MSIs:** Use `candle.exe` and `light.exe` with the respective `.wxs` files (`vbcrun.wxs`, `vcrun.wxs`, `vbrun.wxs`) to build the legacy runtime MSIs.
3.  **Admin Install:** Perform administrative installations for these generated MSIs.

---

## Universal C Runtime (UCRT)

1.  **Download:** Download the necessary MSU files (links provided in the original document) for your target Windows versions.
2.  **Install:** Place MSU files next to `UCRT.cmd` and run the script.

---

## Final AIO Installer Assembly

1.  **Organize:** Group all created administrative installation directories (`2005`, `2008`, `2010`, `2012`, `2013`, `2022`, `ucrt`, `vbc`, `vstor`) into an `_AIO` folder. Include the essential `7zSfx_x86_x64.cmd`, `7zSfx_x86only.cmd`, `7zSfxConfig.txt`, `7zSfxMod.sfx`, `ARP.cmd`, `Installer.cmd`, and `Uninstaller.cmd` files.
2.  **Update Installer Script:** Run `MSIProductCode.vbs` for new MSI files to get ProductCodes. Edit `Installer.cmd` (around line 180) to update `_verXX` and `code` variables for new runtime versions.
3.  **Update SFX Module:** Use a resource editor to update the `File Version` and `Product Version` for `7zSfxMod.sfx` to match the latest VC++ 14 version.
4.  **Create AIOs:** Run `7zSfx_x86_x64.cmd` and/or `7zSfx_x86only.cmd` to build the final AIO installers.
    * *(Note: Scripts expect `7z.exe` at `"%ProgramFiles%\7-Zip"`. Adjust if needed. `-bso0` requires 7-Zip 15.01+).*
