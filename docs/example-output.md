# 📦 Example Output of CI Pipeline

This document provides an overview of the outputs generated during the Continuous Integration (CI) pipeline for the embedded DevSecOps project based on Zephyr RTOS.

---

## 🧾 CI Logs

### 🛠️ Build Log
[114/116] Building C object zephyr/CMakeFiles/zephyr_final.dir/misc/empty_file.c.obj
[115/116] Building C object zephyr/CMakeFiles/zephyr_final.dir/isr_tables.c.obj
[116/116] Linking C executable zephyr/zephyr.elf
Memory region         Used Size  Region Size  %age Used
           FLASH:       14000 B       256 KB      5.34%
             RAM:          4 KB        64 KB      6.25%
        IDT_LIST:          0 GB        32 KB      0.00%
Generating files from /home/runner/work/CI_CD/CI_CD/build/zephyr/zephyr.elf for board: qemu_cortex_m3
[INFO] Build completed successfully.



https://github.com/Sharvanandchaudary/CI_CD/blob/main/images/build-status.png
---

### 🧬 SBOM Export Log
Run echo "[INFO] Exporting Software Bill of Materials (SBOM)..."
[INFO] Exporting Software Bill of Materials (SBOM)...
[0000]  WARN no explicit name and version provided for directory source, deriving artifact ID from the given path (which is not ideal)
[INFO] SBOM exported successfully to build/sbom.spdx.json


https://github.com/Sharvanandchaudary/CI_CD/blob/main/images/SBOM.png?raw=true

---

### 🔐 Hashing Artifact Log
[INFO] Hashing firmware artifact...
[INFO] SHA-256 hash:
d219f27f2342fa46cced39758eb530ef45c83e7b1692067078015d5ba5096adf  build/zephyr/zephyr.elf


https://github.com/Sharvanandchaudary/CI_CD/blob/main/images/hashing-artifact.png?raw=true

---

### 📟 UART Output Log
[INFO] UART Output Log:
[0/1] To exit from QEMU enter: 'CTRL+a, x'[QEMU] CPU: cortex-m3
*** Booting Zephyr OS build v4.1.0-3758-g81ee15787672 ***
Hello World! qemu_cortex -v2 qemu_cortex_m3
ninja: build stopped: interrupted by user.
Hello World! qemu_cortex -v2 qemu_cortex_m3


![UART Log Screenshot](images/UART-log.png)  
[🔗 View full image](images/UART-log.png)

---

### ☁️ Upload Artifacts Log
Finished uploading artifact content to blob storage!
SHA256 digest of uploaded artifact zip is 23611352697830659f2b6d6b182c4691cab21f4cf2658fa9ebb29c5b5d2bc222
Finalizing artifact upload
Artifact uart-output-log.zip successfully finalized. Artifact ID 3100312288
Artifact uart-output-log has been successfully uploaded! Final size is 310 bytes. Artifact ID is 3100312288
Artifact download URL: https://github.com/Sharvanandchaudary/CI_CD/actions/runs/14951317567/artifacts/3100312288

![Upload Artifact Screenshot](images/upload-artifact.png)  
[🔗 View full image](images/upload-artifact.png)

---

## 🧪 Test Log Output

The test results are available in the `build/test_log.json` file and contain the structured UART response output, used for automated validation.

```json
{
  "uart_output": "Hello World from Zephyr!"
}


📎 Files Generated
The following key traceability files are produced and uploaded during the CI workflow:

build/firmware_metadata.json

build/firmware.sha256

build/sbom.spdx.json

build/output.log

build/test_log.json

build/zephyr/zephyr.elf



