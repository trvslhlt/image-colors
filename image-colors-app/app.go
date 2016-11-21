package main

import (
	"fmt"
	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
  "github.com/asaskevich/govalidator"
	"log"
  "io"
  "io/ioutil"
	"net/http"
  "net/url"
	"os"
)

func main() {

  // imgUrl, _ := url.Parse("http://www.jqueryscript.net/images/Simplest-Responsive-jQuery-Image-Lightbox-Plugin-simple-lightbox.jpg")
  // file, err := downloadFile(imgUrl)
  // if err != nil {
  //   panic(err)
  // }
  // fmt.Println(file.Name())

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
	imgPath := r.URL.Query().Get("src")
  if !govalidator.IsURL(imgPath) {
    http.Error(w, "Please use a valid url.", http.StatusBadRequest)
    return
  }
  imgUrl, err := url.Parse(imgPath)
  if err != nil {
    http.Error(w, "Please use a valid url.", http.StatusInternalServerError)
    return
  }

  file, err := downloadFile(imgUrl)
  if err != nil {
    http.Error(w, "We failed to download the iamge file.", http.StatusInternalServerError)
    return
  }
  fmt.Println(file.Name())
  fmt.Println(imgPath)
	fmt.Fprintln(w, "<html><body><img src=\"" + imgPath + "\"></body></html>")
}

// func downloadFile(filepath string, url string) (err error) {
func downloadFile(url *url.URL) (f *os.File, err error) {

  // create the local file
  file, err := ioutil.TempFile("", "img")
  if err != nil {
    return nil, err
  }
  defer file.Close()

  resp, err := http.Get(url.String())
  if err != nil {
    return nil, err
  }
  defer resp.Body.Close()

  _, err = io.Copy(file, resp.Body)
  if err != nil {
    return nil, err
  }

  return file, nil
}
