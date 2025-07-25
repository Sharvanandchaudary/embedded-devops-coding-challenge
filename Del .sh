⚠️ Warning: This will permanently delete volumes.
Double-check the names or adjust the filter before running.

Script: delete_highmem_volumes.sh
bash
Copy
Edit
#!/bin/bash
set -e

# Pattern for volume names to delete
PATTERN="highmem"

echo "Fetching volumes matching pattern: $PATTERN"
# List all volumes, filter by pattern, and extract IDs
volume_ids=$(openstack volume list -f value -c ID -c Name | grep "$PATTERN" | awk '{print $1}')

if [ -z "$volume_ids" ]; then
    echo "No volumes found matching pattern: $PATTERN"
    exit 0
fi

echo "Volumes to be deleted:"
echo "$volume_ids"

# Loop through each volume ID and delete
for vol in $volume_ids; do
    echo "Deleting volume: $vol"
    openstack volume delete "$vol"
done

echo "All matching volumes deleted."
