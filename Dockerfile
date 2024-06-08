# Stage 1: Build the Go application
FROM golang:1.21.6 AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go Module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application's source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Stage 2: Setup the runtime container
FROM alpine:latest  

# Add CA certificates to access HTTPS endpoints
RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copy the pre-built binary file from the previous stage
COPY --from=builder /app/main .

# Expose port (if your app uses a port)
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
