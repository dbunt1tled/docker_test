package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"

	_ "github.com/lib/pq"
)

func main() {
	dbHost := os.Getenv("DATABASE_URL")

	log.Println(dbHost)
	db, err := sql.Open("postgres", dbHost)
	if err != nil {
		log.Fatal(err)
	}
	defer func(db *sql.DB) {
		err := db.Close()
		if err != nil {
			log.Fatal(err)
		}
	}(db)

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		var version string
		log.Println("Incoming Request")
		err := db.QueryRow("SELECT version()").Scan(&version)
		if err != nil {
			log.Fatal(err)
		}
		_, err = fmt.Fprintf(w, "Hello from Go! PostgreSQL version: %s", version)
		if err != nil {
			log.Fatal(err)
		}
	})

	err = http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal(err)
	}
}
