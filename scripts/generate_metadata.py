import json
import subprocess
from datetime import datetime

def get(cmd):
    return subprocess.check_output(cmd).decode().strip()

metadata = {
    "git_sha": get(["git", "rev-parse", "HEAD"]),
    "git_version": get(["git", "describe", "--tags", "--always"]),
    "build_time": datetime.utcnow().isoformat() + "Z",
    "toolchain": "Zephyr SDK"
}

with open("firmware_metadata.json", "w") as f:
    json.dump(metadata, f, indent=2)
