#!/bin/sh

# Check for required environment variable
if [ -z "$MINIO_CONFIGURE_FLAG" ]; then
  echo "ERROR: MINIO_CONFIGURE_FLAG environment variable is not set. Exiting."
  exit 1
fi

# Wait for MinIO to be ready
until mc ready minio; do 
  echo 'Waiting for MinIO...'
  sleep 2
done

# Create user
mc admin user add minio internal_apps internal_secret_key

# Create and attach policy
mc admin policy attach minio readwrite --user internal_apps

# Create buckets
mc mb minio/typst-files
mc mb minio/assets-files


# Generate API access keys
echo "Generating API access keys..."
ACCESS_KEYS=$(mc admin accesskey create minio internal_apps --name internal_apps_readwrite 2>&1)

if [ -z "$ACCESS_KEYS" ]; then
  echo "ERROR: Failed to generate access keys" >&2
  exit 1
fi

# Extract keys from new format output
#ACCESS_KEY=$(echo "$ACCESS_KEYS" | awk '/Access Key:/ {print $3}')
#SECRET_KEY=$(echo "$ACCESS_KEYS" | awk '/Secret Key:/ {print $3}')

# Output keys
echo "========================================"
echo "API ACCESS KEYS FOR internal_apps USER:"
echo "$ACCESS_KEYS"
echo "========================================"

echo "MinIO configuration complete!"

