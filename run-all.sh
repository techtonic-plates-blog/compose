
podman compose -f compose.infrastructure.yaml up --build --force-recreate -d;

podman compose -f compose.posts.yaml -p posts-service up --build --force-recreate -d;
podman compose -f compose.assets.yaml -p assets-service up --build --force-recreate -d;

podman compose -f compose.auth.yaml -p auth-service up --build --force-recreate -d;