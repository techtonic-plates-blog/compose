#!/bin/sh

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
mc mb minio/image-files


# Generate API access keys
echo "Generating API access keys..."
ACCESS_KEYS=$(mc admin accesskey add minio internal_apps 2>&1)

if [ -z "$ACCESS_KEYS" ]; then
  echo "ERROR: Failed to generate access keys" >&2
  exit 1
fi

# Extract keys from new format output
ACCESS_KEY=$(echo "$ACCESS_KEYS" | awk '/Access Key:/ {print $3}')
SECRET_KEY=$(echo "$ACCESS_KEYS" | awk '/Secret Key:/ {print $3}')

# Output keys
echo "========================================"
echo "API ACCESS KEYS FOR internal_apps USER:"
echo "Access Key: $ACCESS_KEY"
echo "Secret Key: $SECRET_KEY"
echo "========================================"

echo "MinIO configuration complete!"