.PHONY: help build run test docker-build docker-run docker-push helm-install helm-uninstall k8s-deploy k8s-delete

# Default target
help:
	@echo "Available targets:"
	@echo "  build           - Build the Go application"
	@echo "  run             - Run the application locally"
	@echo "  test           - Run tests"
	@echo "  docker-build    - Build Docker image"
	@echo "  docker-run      - Run Docker container"
	@echo "  compose-up     - Start all services with docker-compose"
	@echo "  compose-down   - Stop all services with docker-compose"
	@echo "  helm-install   - Install Helm chart"
	@echo "  helm-uninstall - Uninstall Helm chart"
	@echo "  k8s-deploy     - Deploy to Kubernetes"
	@echo "  k8s-delete     - Delete Kubernetes resources"

# Build the Go application
build:
	go build -o bin/docker_test

# Run the application
run:
	go run main.go

# Run tests
test:
	go test -v ./...

# Build Docker image
docker-build:
	docker build -t dbunt1tled/test_docker:latest .

# Run Docker container
docker-run:
	docker run -p 8080:8080 --env-file .env dbunt1tled/test_docker:latest

# Start all services with docker-compose
compose-up:
	docker-compose up -d

# Stop all services with docker-compose
compose-down:
	docker-compose down

# Install Helm chart
helm-install:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
	helm install ingress-nginx ingress-nginx/ingress-nginx

# Uninstall Helm chart
helm-uninstall:
	helm uninstall ingress-nginx

# Deploy to Kubernetes
k8s-deploy:
	kubectl apply -f k8s/

# Delete Kubernetes resources
k8s-delete:
	kubectl delete -f k8s/
