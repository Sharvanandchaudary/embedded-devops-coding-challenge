# scripts/generate_metadata.py
import os
import json
import datetime
import subprocess

metadata = {
    "git_sha": subprocess.check_output(["git", "rev-parse", "HEAD"]).decode().strip(),
    "git_description": subprocess.check_output(["git", "describe", "--always"]).decode().strip(),
    "build_time": datetime.datetime.utcnow().isoformat() + "Z"
}

with open("build/firmware_metadata.json", "w") as f:
    json.dump(metadata, f, indent=2)  # <-- ✅ this adds line-by-line formatting
