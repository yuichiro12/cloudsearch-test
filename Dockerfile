###########
##  bin  ##
###########
FROM golang:alpine AS bin
RUN mkdir -p /usr/local/bin
RUN mkdir -p /usr/local/share
WORKDIR /usr/local/share
COPY . /usr/local/share
RUN go build -o /usr/local/bin/cloudsearch-test

############
##  base  ##
############
FROM alpine:latest AS base
RUN apk add --no-cache ca-certificates
COPY --from=bin /usr/local/bin /usr/local/bin
CMD ["/usr/local/bin/cloudsearch-test"]

#############
##  local  ##
#############
FROM base AS local
COPY ./build/secret /root/.aws

###########
##  dev  ##
###########
FROM base AS dev

###########
##  prd  ##
###########
FROM base AS prd
