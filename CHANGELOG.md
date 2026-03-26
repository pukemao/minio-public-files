# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Added

- Independent project layout under `/Users/pukemao/Projects/minio-public-files`
- `Makefile` command entrypoints for common operations
- `scripts/compose.sh` to support both `docker compose` and `docker-compose`
- `scripts/init-public-bucket.sh` for bucket bootstrap logic
- `.editorconfig` and `.gitignore` for repository hygiene

### Changed

- Renamed Compose file to `compose.yaml`
- Moved runtime data mount to the new standalone project path
- Rewrote `README.md` to match the normalized project structure
