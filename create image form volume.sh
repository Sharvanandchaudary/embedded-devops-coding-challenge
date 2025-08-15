#!/bin/bash

# --- Input Parameters ---

read -p "Enter the name or ID of the server to stop: " SERVER_ID_OR_NAME

read -p "Enter the desired image name: " IMAGE_NAME

read -p "Enter the Volume ID to create the image from: " VOLUME_ID

read -p "Enter the disk format (e.g., qcow2, raw, vmdk) [qcow2]: " DISK_FORMAT
DISK_FORMAT=${DISK_FORMAT:-qcow2}

read -p "Enter the container format (e.g., bare, ami) [bare]: " CONTAINER_FORMAT
CONTAINER_FORMAT=${CONTAINER_FORMAT:-bare}

read -p "Enter the minimum disk size in GB (optional, press Enter to skip): " MIN_DISK
if [[ -n "$MIN_DISK" ]]; then
  MIN_DISK_PARAM="--min-disk $MIN_DISK"
else
  MIN_DISK_PARAM=""
fi

read -p "Enter the minimum RAM in MB (optional, press Enter to skip): " MIN_RAM
if [[ -n "$MIN_RAM" ]]; then
  MIN_RAM_PARAM="--min-ram $MIN_RAM"
else
  MIN_RAM_PARAM=""
fi

read -p "Should the image be bootable? (yes/no) [yes]: " BOOTABLE
BOOTABLE=${BOOTABLE:-yes}

# --- Validate Input (optional) ---
# Add more robust validation here, e.g., checking if the server/volume ID exists.

# --- Stop the Server ---

echo "Stopping server '$SERVER_ID_OR_NAME' to make the volume available..."
openstack server stop "$SERVER_ID_OR_NAME"

if [[ $? -eq 0 ]]; then
  echo "Server '$SERVER_ID_OR_NAME' stop initiated."
else
  echo "Error stopping server '$SERVER_ID_OR_NAME'. Aborting."
  exit 1
fi

# --- Wait for Volume to be Available ---

echo "Waiting for volume '$VOLUME_ID' to become 'available'..."
until openstack volume show "$VOLUME_ID" -c status -f value | grep -q "available"; do
  echo "Volume status: $(openstack volume show "$VOLUME_ID" -c status -f value). Waiting..."
  sleep 5
done
echo "Volume '$VOLUME_ID' is now available."

# --- Image Creation ---

echo "Creating OpenStack image '$IMAGE_NAME' from volume '$VOLUME_ID'..."

CREATE_IMAGE_CMD="openstack image create \"$IMAGE_NAME\" --volume \"$VOLUME_ID\" --disk-format \"$DISK_FORMAT\" --container-format \"$CONTAINER_FORMAT\" $MIN_DISK_PARAM $MIN_RAM_PARAM"

if [[ "$BOOTABLE" == "yes" ]]; then
  CREATE_IMAGE_CMD="$CREATE_IMAGE_CMD --property hw_boot_disk=true"
else
  CREATE_IMAGE_CMD="$CREATE_IMAGE_CMD --property hw_boot_disk=false"
fi

$CREATE_IMAGE_CMD

if [[ $? -eq 0 ]]; then
  echo "Image '$IMAGE_NAME' created successfully!"
  echo "Image details for '$IMAGE_NAME':"
  openstack image show "$IMAGE_NAME"
else
  echo "Error creating image '$IMAGE_NAME'."
fi
