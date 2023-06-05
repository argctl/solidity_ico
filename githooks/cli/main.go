package main

import (
	"fmt"
	"io"
	"net/http"
)

// TODO - run handshake with other services and hash, etc
func main() {
	pretendHash := "abc123"
	fmt.Println(pretendHash)
	resp, err := http.Get("http://localhost:8000/precommit")
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		panic(err)
	}
	// TODO - use unmasheable
	fmt.Println(string(body))
}
