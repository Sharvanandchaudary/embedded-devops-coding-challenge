# Example Output of CI Pipeline

This document provides an overview of the example outputs generated during the Continuous Integration (CI) pipeline for the embedded DevOps coding challenge.

## CI Logs

### Build Log
```
[INFO] Starting build process...
[INFO] Installing dependencies...
[INFO] Building firmware...
[INFO] Build completed successfully.
```

### SBOM Export Log
```
[INFO] Exporting Software Bill of Materials (SBOM)...
[INFO] SBOM exported successfully to metadata/sbom.spdx.json.
```

### Hashing Artifact Log
```
[INFO] Hashing firmware artifact...
[INFO] SHA-256 hash: abcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890
[INFO] Hash saved to metadata/firmware.sha256.
```

## Screenshots

### Build Status
![Build Status](https://example.com/path/to/build-status-screenshot.png)

### SBOM Output
![SBOM Output](https://example.com/path/to/sbom-output-screenshot.png)

## Test Logs

The test logs can be found in the `test_log.json` file, which contains detailed information about the tests executed during the CI process.

---

This document should be updated with actual logs and screenshots after running the CI pipeline for the first time.