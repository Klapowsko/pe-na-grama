.PHONY: help build up down logs clean rebuild

help:
	@echo "Penagrama - Available targets:"
	@echo "  make build       - Copy .env-example to .env and build Docker images"
	@echo "  make up          - Start containers"
	@echo "  make down        - Stop containers"
	@echo "  make logs        - View container logs"
	@echo "  make clean       - Remove containers and volumes"
	@echo "  make rebuild     - Rebuild and restart containers"

build:
	@echo "Setting up environment..."
	@if [ ! -f .env ]; then cp .env-example .env && echo ".env created from .env-example"; else echo ".env already exists"; fi
	@echo "Building Docker images..."
	docker-compose build

up: build
	@echo "Starting containers..."
	docker-compose up -d
	@echo "✓ Application started at http://localhost:8080"
	@echo "✓ MongoDB at localhost:27017"

down:
	@echo "Stopping containers..."
	docker-compose down

logs:
	docker-compose logs -f

clean:
	@echo "Removing containers and volumes..."
	docker-compose down -v
	@echo "✓ Cleanup complete"

rebuild: clean up
	@echo "✓ Rebuild complete"
