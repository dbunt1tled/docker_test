# Docker Test Application

[![Build](https://github.com/dbunt1tled/docker_test/actions/workflows/ci.yml/badge.svg)](https://github.com/dbunt1tled/docker_test/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/dbunt1tled/test_docker)](https://hub.docker.com/r/dbunt1tled/test_docker)
[![Go Report Card](https://goreportcard.com/badge/github.com/dbunt1tled/docker_test)](https://goreportcard.com/report/github.com/dbunt1tled/docker_test)

A production-ready Go web application with PostgreSQL integration, containerized with Docker and deployable to Kubernetes using Helm.

## ✨ Features

- 🚀 **RESTful API** - Simple HTTP server running on port 8080
- 🗄 **PostgreSQL Integration** - Robust database connectivity
- 🐳 **Containerized** - Ready for Docker and Kubernetes
- 🔄 **CI/CD Pipeline** - Automated testing and deployment with GitHub Actions
- ☸ **Kubernetes Support** - Helm charts for easy deployment
- 🔧 **Makefile** - Simplified development workflow
- 🔒 **Secure** - Environment-based configuration and secrets management

## 🚀 Quick Start

### Prerequisites

- Go 1.22 or higher
- Docker 20.10+ and Docker Compose
- PostgreSQL 13+
- kubectl (for Kubernetes deployment)
- Helm 3.0+

### Using Makefile

The project includes a `Makefile` to simplify common tasks:

```bash
# Build and run the application
make build
make run

# Run tests
make test

# Build and run with Docker
make docker-build
make docker-run

# Use docker-compose
make compose-up
make compose-down

# Kubernetes deployment
make helm-install
make k8s-deploy
```

## 🛠 Development

### Environment Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/dbunt1tled/docker_test.git
   cd docker_test
   ```

2. Create a `.env` file in the root directory:
   ```bash
   cp .env.example .env
   ```
   Then update the variables in `.env` as needed.

### Configuration

The application is configured using environment variables:

| Variable       | Default Value                     | Description                           |
|----------------|-----------------------------------|---------------------------------------|
| `PORT`         | `8080`                           | Port to run the server on             |
| `DATABASE_URL` | `postgres://user:pass@db:5432/db` | PostgreSQL connection string          |
| `LOG_LEVEL`    | `info`                           | Logging level (debug, info, warn, error) |

### Running Locally

1. Install dependencies:
   ```bash
   go mod download
   ```

2. Start the application:
   ```bash
   make run
   ```
   or for development with hot-reload:
   ```bash
   air
   ```

3. Access the application:
   - API: http://localhost:8080
   - Health check: http://localhost:8080/health

## 🐳 Docker

### Building the Image

```bash
docker build -t dbunt1tled/test_docker:latest .
```

### Running with Docker

```bash
docker run -p 8080:8080 --env-file .env dbunt1tled/test_docker:latest
```

### Docker Compose

For development with a local PostgreSQL instance:

```bash
docker-compose up -d
```

This will start:
- Application container
- PostgreSQL database
- PgAdmin (optional)
- Any other services defined in `docker-compose.yml`

## 🧪 Testing

Run unit tests:

```bash
make test
```

Run tests with coverage:

```bash
go test -coverprofile=coverage.out ./...
go tool cover -html=coverage.out -o coverage.html
```

## 🔄 CI/CD Pipeline

The GitHub Actions workflow includes:

1. **Test** - Run unit tests on every push
2. **Build** - Build the application
3. **Docker Build** - Create Docker image on main branch
4. **Docker Push** - Push to Docker Hub on version tags (v*.*.*)

### Manual Deployment

To deploy a new version:

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

## 📁 Project Structure

```
.
├── .github/            # GitHub configurations
│   └── workflows/      # CI/CD workflows
├── db/                 # Database initialization scripts
├── helm/               # Helm charts for Kubernetes
├── nginx/              # Nginx configuration
├── terraform-aws/      # AWS infrastructure as code
├── terraform-demo/     # Example Terraform configurations
├── .dockerignore
├── .env.example        # Environment variables template
├── .gitignore
├── Dockerfile
├── Makefile            # Development and deployment tasks
├── docker-compose.yml  # Local development stack
├── go.mod             # Go module definition
├── go.sum             # Go dependencies checksums
├── main.go            # Application entry point
└── main_test.go       # Test files
```

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Code Style

- Follow the [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)
- Run `gofmt` and `golint` before committing
- Write tests for new features

### Commit Message Format

```
<type>(<scope>): <subject>

[optional body]

[optional footer(s)]
```

Example:
```
feat(api): add user authentication

- Add JWT authentication middleware
- Implement login/logout endpoints
- Add user model and migrations

Closes #123
```

## ☸ Kubernetes Deployment

### Prerequisites

- Kubernetes cluster (Minikube, EKS, GKE, etc.)
- kubectl configured
- Helm 3.0+

### Deploy with Helm

1. Add the Helm repository:
   ```bash
   helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
   ```

2. Install the Nginx Ingress Controller:
   ```bash
   helm install ingress-nginx ingress-nginx/ingress-nginx \
     --namespace ingress-nginx \
     --create-namespace \
     --set controller.publishService.enabled=true
   ```

3. Deploy the application:
   ```bash
   helm install inwebapp ./helm/inwebapp
   ```

4. Access the application:
   ```bash
   # Get the pod name
   kubectl get pods -n ingress-nginx
   
   # Forward port
   kubectl port-forward -n ingress-nginx <nginx-ingress-pod> 8080:80
   
   # Access the app
   curl -H "Host: inwebapp.local" http://127.0.0.1:8080/
   ```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with ❤️ using [Go](https://golang.org/)
- [PostgreSQL](https://www.postgresql.org/) for reliable data storage
- [Docker](https://www.docker.com/) for containerization
- [Kubernetes](https://kubernetes.io/) for orchestration
- [Helm](https://helm.sh/) for Kubernetes package management

## 🔗 Useful Links

- [Go Documentation](https://golang.org/doc/)
- [Docker Documentation](https://docs.docker.com/)
- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Helm Documentation](https://helm.sh/docs/)
