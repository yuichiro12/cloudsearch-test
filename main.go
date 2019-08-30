package main

import (
	"io"
	"log"
	"net/http"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/cloudsearchdomain"
	"github.com/gorilla/mux"
)

func main() {
	// CloudSearchDomain methods are safe to use concurrently. It is not safe to
	// modify mutate any of the struct's properties though.
	cs := NewCloudSearchDomainClient()

	router := mux.NewRouter()
	router.HandleFunc("/search", func(w http.ResponseWriter, r *http.Request) {
		val := r.URL.Query()
		q := val.Get("q")
		input := &cloudsearchdomain.SearchInput{Query: &q}
		output, err := cs.Search(input)
		if err != nil {
			if _, err := io.WriteString(w, err.Error()); err != nil {
				log.Fatal(err)
			}
		} else if _, err := io.WriteString(w, output.String()); err != nil {
			log.Fatal(err)
		}
	})

	log.Fatal(http.ListenAndServe(":8443", router))
}

func NewCloudSearchDomainClient() *cloudsearchdomain.CloudSearchDomain {
	ep := os.Getenv("CLOUDSEARCHDOMAIN_SEARCH_ENDPOINT")
	config := aws.NewConfig().WithRegion("us-west-1").WithEndpoint(ep)
	sess, err := session.NewSession(config)
	if err != nil {
		log.Fatal(err)
	}
	return cloudsearchdomain.New(sess)
}
