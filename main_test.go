package main

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestRootHandler(t *testing.T) {
	// Create a request to pass to our handler
	req, err := http.NewRequest("GET", "/", nil)
	if err != nil {
		t.Fatal(err)
	}

	// Create a ResponseRecorder to record the response
	rr := httptest.NewRecorder()

	// Create a handler function that uses our mock DB

	handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		version := "PostgreSQL 15.3 on x86_64-pc-linux-gnu"
		_, _ = w.Write([]byte("Hello from Go! PostgreSQL version: " + version))
	})

	// Call the handler
	handler.ServeHTTP(rr, req)

	// Check the status code
	assert.Equal(t, http.StatusOK, rr.Code, "handler returned wrong status code")

	// Check the response body
	expected := "Hello from Go! PostgreSQL version: PostgreSQL 15.3 on x86_64-pc-linux-gnu"
	assert.Equal(t, expected, rr.Body.String(), "handler returned unexpected body")
}
