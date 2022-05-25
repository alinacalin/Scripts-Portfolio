package main

import (
	"fmt"
	"math"
)

func Sqrt(x float64) float64 {
	z := 1.0
	z1 := 0.0
	for math.Abs(z-z1) > 0.00001 {
		z1 = z
		z -= (z*z - x) / (2 * z)
		fmt.Println(z)
	}
	return z
}

func main() {
	fmt.Println("The square root of 66 is ", Sqrt(66))
}

// to run the program in terminal, type:  go run square_root.go
