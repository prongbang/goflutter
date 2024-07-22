package main

/*
#include <stdint.h>

// Declaration of the Go function to be called from C
extern void Hello();
*/
import "C"
import "fmt"

//export Hello
func Hello() {
    fmt.Println("Hello from Go")
}

func main() {}
