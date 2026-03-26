#!/usr/bin/env sh
set -eu

: "${MINIO_ROOT_USER:?MINIO_ROOT_USER is required}"
: "${MINIO_ROOT_PASSWORD:?MINIO_ROOT_PASSWORD is required}"
: "${MINIO_PUBLIC_BUCKET:?MINIO_PUBLIC_BUCKET is required}"

mc alias set local http://minio:9000 "$MINIO_ROOT_USER" "$MINIO_ROOT_PASSWORD"
mc mb --ignore-existing "local/$MINIO_PUBLIC_BUCKET"
mc anonymous set download "local/$MINIO_PUBLIC_BUCKET"

echo "Public bucket ready: $MINIO_PUBLIC_BUCKET"
