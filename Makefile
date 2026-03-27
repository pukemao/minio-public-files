SHELL := /bin/sh
COMPOSE := ./scripts/compose.sh
.DEFAULT_GOAL := help

.PHONY: help up down restart ps logs config public-url health

help:
	@echo "Available targets:"
	@echo "  make up         Start services in background"
	@echo "  make down       Stop and remove services"
	@echo "  make restart    Restart services"
	@echo "  make ps         Show service status"
	@echo "  make logs       Tail MinIO logs"
	@echo "  make config     Render merged Compose config"
	@echo "  make public-url Print public bucket base URL"
	@echo "  make health     Check MinIO liveness endpoint"

up:
	@$(COMPOSE) up -d

down:
	@$(COMPOSE) down

restart: down up

ps:
	@$(COMPOSE) ps

logs:
	@$(COMPOSE) logs -f minio

config:
	@$(COMPOSE) config

public-url:
	@server_url="http://127.0.0.1:$$(awk -F= '/^MINIO_API_PORT=/{print $$2}' .env)"; \
	bucket=$$(awk -F= '/^MINIO_PUBLIC_BUCKET=/{print $$2}' .env); \
	printf '%s/%s\n' "$$server_url" "$$bucket"

health:
	@server_url="http://127.0.0.1:$$(awk -F= '/^MINIO_API_PORT=/{print $$2}' .env)"; \
	curl -fsS "$$server_url/minio/health/live"
