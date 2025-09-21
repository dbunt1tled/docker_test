# Docker Test Application

![Build](https://github.com/<username>/<repo>/actions/workflows/docker.yml/badge.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/username/myapp)

A simple Go web application that connects to a PostgreSQL database and serves the database version via an HTTP endpoint.

## Features

- Simple HTTP server that runs on port 8080
- Connects to a PostgreSQL database
- Exposes a single endpoint (`/`) that returns the PostgreSQL version
- Containerized with Docker
- Automated CI/CD pipeline with GitHub Actions

## Prerequisites

- Go 1.22 or higher
- Docker (for containerization)
- PostgreSQL (for local development)

## Getting Started

### Environment Variables

Create a `.env` file in the root directory with the following variables:

```
DATABASE_URL=postgres://username:password@host:port/dbname?sslmode=disable
```

### Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/docker_test.git
   cd docker_test
   ```

2. Install dependencies:
   ```bash
   go mod tidy
   ```

3. Run the application:
   ```bash
   go run main.go
   ```

4. Access the application:
   ```
   http://localhost:8080
   ```

### Building with Docker

1. Build the Docker image:
   ```bash
   docker build -t docker_test .
   ```

2. Run the container:
   ```bash
   docker run -p 8080:8080 --env-file .env docker_test
   ```

## Testing

Run the tests:

```bash
go test -v ./...
```

## CI/CD

This project includes a GitHub Actions workflow that:

1. Runs tests on push to main branch
2. Builds the application
3. Builds and pushes a Docker image to Docker Hub on version tags (v*.*.*)

## Project Structure

```
.
├── .github/workflows/  # GitHub Actions workflows
├── db/                 # Database initialization scripts
├── nginx/             # Nginx configuration
├── .dockerignore
├── .gitignore
├── Dockerfile
├── docker-compose.yml
├── go.mod
├── go.sum
├── main.go            # Application entry point
└── main_test.go       # Test files
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with Go
- Uses PostgreSQL for data storage
- Containerized with Docker
