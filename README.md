# Golang: my first application "Hello World!"

![image](https://github.com/luiscoco/Golang-sample1-Hello-World/assets/32194879/95983f62-34fc-45de-be30-65e2568dd85a)

![image](https://github.com/luiscoco/Golang-sample1-Hello-World/assets/32194879/8f2e6a07-5421-4186-947d-9a7069cda0ee)

Let's break down your Go code step by step:

## 1. Package Declaration

```go
package main
```

**package main**: This line declares that the file belongs to the main package
In Go, a package is a way to group related Go source files together
The main package is special because it defines a standalone executable program. When you run a Go program, the entry point of the execution is the main function within the main package

## 2. Import Statements

```go
import (
    "fmt"
    "github.com/google/uuid"
)
```

**import**: This keyword is used to include other packages into your program

**"fmt"**: This is a standard Go package that provides input and output functionalities, such as printing to the console

**"github.com/google/uuid"**: This is an external package that provides functionalities for generating UUIDs (Universally Unique Identifiers)


## 3. Main Function

```go
func main() {
    // Print a hello message
    fmt.Println("Hello, World!")
    // Generate and print a UUID
    fmt.Println("Your unique ID is:", uuid.New().String())
}
```

**func main() { ... }**: This defines the main function, which is the entry point of a Go program

The main function is executed automatically when the program starts

Inside the main function:

**Print a Hello Message**

```go
fmt.Println("Hello, World!")
```

**fmt.Println**: This function from the fmt package prints the string "Hello, World!" to the console, followed by a newline

**Generate and Print a UUID**

```go
fmt.Println("Your unique ID is:", uuid.New().String())
```

**uuid.New()**: This function from the uuid package generates a new UUID

**.String()**: This method converts the UUID to its string representation

**fmt.Println**: This prints the string "Your unique ID is:" followed by the generated UUID to the console

**Summary**

The program starts by executing the main function

It prints "Hello, World!" to the console

It generates a new UUID using the uuid package and prints it to the console with the message "Your unique ID is: "

UUIDs are useful for creating unique identifiers that are unlikely to collide, making them ideal for use in distributed systems or for creating unique database keys

## 4. How to run the application in VSCode

```
go run hello.go
```

## 5. Dockerfile

```dockerfile
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
```

### 5.1. Run the following command to build your Docker image

```
docker build -t my-go-app .
```

Replace **my-go-ap** with the name you want for your Docker image

The . at the end of the command specifies the current directory as the build context

### 5.2. Run the Docker container

After the image is built, you can run a container using the image:

```
docker run -p 8080:8080 my-go-app
```

This command maps port 8080 of the host to **port 8080** of the container, allowing you to access your application through **http://localhost:8080**

![image](https://github.com/luiscoco/Golang-sample1-Hello-World/assets/32194879/024f52e8-48d8-48b4-aa52-a997ed158bbb)

![image](https://github.com/luiscoco/Golang-sample1-Hello-World/assets/32194879/0b8719f7-4bae-4c79-a6bb-963e076f2241)


