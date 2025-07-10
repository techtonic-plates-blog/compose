MINIO_ACCESS=YX0Q15RENVBF6FQZZ8BD MINIO_SECRET=0fC0ypCecVIwiGZn68l4+8r5nwzv89Rdgf8aBbas podman compose -f compose.posts.yaml -p posts-service up --build --force-recreate -d;
podman compose -f compose.auth.yaml -p auth-service up --build --force-recreate -d;
podman compose -f compose.infrastructure.yaml up --build --force-recreate -d;