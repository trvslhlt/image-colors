package main

import (
	"fmt"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"os"
)

func main() {
	r := mux.NewRouter()
	r.Methods("GET").Path("/").HandlerFunc(Index)
	r.Methods("GET").Path("/api/num_colors").HandlerFunc(ApiNumColors)
	loggedR := handlers.LoggingHandler(os.Stdout, r)
	fmt.Println("Now listening on port 8080")
	log.Fatal(http.ListenAndServe(":8080", loggedR))
}

func Index(w http.ResponseWriter, r *http.Request) {
	fmt.Println(r.URL.Query())
	fmt.Fprintln(w, "visit /api/num_colors?src=<image url> to get the number of colors in your image")
}

func ApiNumColors(w http.ResponseWriter, r *http.Request) {
	imgUrl := r.URL.Query().Get("src")
	fmt.Fprintf(w, "%s", imgUrl)
}
