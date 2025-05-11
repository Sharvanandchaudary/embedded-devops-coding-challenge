#Zephyr CI DevSecOps Firmware Project

This repository demonstrates a full CI/CD pipeline for building, testing, and verifying embedded firmware using Zephyr RTOS. The workflow includes compilation, simulation, SBOM generation, traceability, and log analysis.

Project Overview

* Firmware: Zephyr Hello World application
* Target Board: qemu\_cortex\_m3
* Toolchain: Zephyr SDK v0.16.3
* Build System: west
* CI/CD: GitHub Actions
* SBOM Generation: Syft
* Traceability: Git metadata, SHA256, structured UART log

Local Setup and Build Instructions

1. Install Zephyr SDK version 0.16.3
2. Install Python 3, pip, `west`, `qemu-system-arm`, `jq`
3. Clone the repository
4. Run the following commands:

   west init -l project/hello\_world
   west update
   west build -b qemu\_cortex\_m3 project/hello\_world -p always
   west build -t run

CI/CD Pipeline Summary (GitHub Actions)

This workflow is triggered on every push or pull request to the `main` branch. It performs the following:

1. Checkout the repo with submodules
2. Install all required packages and toolchains
3. Set up Zephyr environment using `west`
4. Build the firmware with west
5. Generate a SHA256 hash of the output firmware
6. Simulate the firmware using QEMU and log UART output
7. Convert UART log to JSON
8. Generate structured metadata file with git SHA, timestamp, toolchain
9. Generate an SPDX SBOM using Syft
10. Validate SBOM format using jq
11. Upload all generated artifacts (elf, metadata, SBOM, checksum, UART log)

Traceability Outputs

firmware\_metadata.json:
{
"git\_sha": "4022cc4eb574234db012b1a898b0e422425540ab",
"git\_description": "4022cc4",
"build\_time": "2025-05-11T01:22:09Z",
"toolchain": {
"name": "Zephyr SDK",
"version": "0.16.3"
},
"target\_board": "qemu\_cortex\_m3",
"firmware\_output": "build/zephyr/zephyr.elf"
}

sbom.spdx.json:

* SPDX Version: 2.3
* Created using Syft 1.23.1
* Describes build/zephyr/zephyr.elf and prelinked ELF files

firmware.sha256:
d219f27f2342fa46cced39758eb530ef45c83e7b1692067078015d5ba5096adf  build/zephyr/zephyr.elf

test\_log.json:
{
"uart\_output": "\[QEMU] CPU: cortex-m3\*\*\* Booting Zephyr OS build v4.1.0-3758-g81ee15787672 \*\*\* Hello World! qemu\_cortex -v2 qemu\_cortex\_m3"
}

Where to Place Screenshots and Logs

* docs/example-output.md: Add commentary or logs describing CI stages
* docs/screenshot\_build.png: Screenshot of build stage from GitHub Actions
* docs/screenshot\_uart.png: Screenshot of UART output from GitHub Actions or console

Submit These Files in the Repository

Required:

* build/zephyr/zephyr.elf (firmware binary)
* build/firmware\_metadata.json
* build/sbom.spdx.json
* build/firmware.sha256
* build/test\_log.json
* .github/workflows/ci.yaml (CI pipeline)
* README.md (this file)

Optional:

* docs/example-output.md (with screenshot references)
* walkthrough.mp4 (demo video of the flow)
* COMPLIANCE.md (if compliance constraints are added)

Directory Structure

* metadata/: Contains firmware\_metadata.json, sbom.spdx.json, firmware.sha256
* docs/: Documentation, screenshots, example-output.md
* project/hello\_world/: Firmware source (src/, test/, CMakeLists.txt)
* scripts/: generate\_metadata.py and other helper scripts
* .github/workflows/: Contains ci.yaml

Committing Traceability to Repo (Optional Step)

1. Download traceability artifacts from GitHub Actions
2. Move the files to the metadata/ directory
3. Commit and push

   git add metadata/
   git commit -m "Add traceability files"
   git push origin main
