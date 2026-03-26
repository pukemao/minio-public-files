#!/usr/bin/env sh
set -eu

script_dir=$(
  CDPATH= cd -- "$(dirname -- "$0")" && pwd
)
project_dir=$(dirname "$script_dir")
compose_file="$project_dir/compose.yaml"

if docker compose version >/dev/null 2>&1; then
  exec docker compose -f "$compose_file" --project-directory "$project_dir" "$@"
fi

if command -v docker-compose >/dev/null 2>&1; then
  exec docker-compose -f "$compose_file" "$@"
fi

echo "Neither 'docker compose' nor 'docker-compose' is available." >&2
exit 1
