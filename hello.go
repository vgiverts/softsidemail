package main

import (
	"fmt"
	"net/http"
	"softside/softmail"
)

type Page struct {
	Title string
	Body  []byte
}

func main() {

	//print(url.QueryEscape("http://fake-domain.com/dummy-path?param=val"))
	//print(softmail.UrlToId("/asdf2"))
	testEmailTracker()

	//testSendMail()

	//softmail.StartSqs()

}

func testSendMail() {
	err := softmail.Sendmail("test body", "/Users/vlad/go/src/softside/testemail.txt", "vlad@softsideoftech.com")
	if (err != nil) {
		fmt.Println(err)
	}
}

func testEmailTracker() {
	http.HandleFunc("/favicon.ico", HandleFavicon)
	http.HandleFunc("/gen_link", softmail.GenerateTrackingLink)
	http.HandleFunc("/", softmail.TrackRequest)
	http.ListenAndServe(":8080", nil)
}

func HandleFavicon(w http.ResponseWriter, r *http.Request) {
	favIconUrl := "http://static.softsideoftech.com/favicon.ico"
	http.Redirect(w, r, favIconUrl, http.StatusTemporaryRedirect)
}
