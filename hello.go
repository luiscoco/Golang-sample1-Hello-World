// package main

// import "fmt"

// func main() {
//     fmt.Println("Hello, World!")
// }

package main

import (
    "fmt"
    "github.com/google/uuid"
)

func main() {
    // Print a hello message
    fmt.Println("Hello, World!")
    // Generate and print a UUID
    fmt.Println("Your unique ID is:", uuid.New().String())
}

