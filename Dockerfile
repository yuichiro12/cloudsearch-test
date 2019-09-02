FROM alpine:latest
COPY ./bin /usr/local/bin
CMD ["/usr/local/bin/cloudsearch-test"]
