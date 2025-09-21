# ===== Stage 1: build =====
FROM golang:1.22-alpine AS build_go
WORKDIR /app

RUN apk add --no-cache git

COPY . .
RUN go mod download
RUN go build -o app main.go

# ===== Stage 2: runtime =====
FROM alpine:3.18
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
USER appuser

COPY --from=build_go /app/app .
EXPOSE 8080
CMD ["./app"]