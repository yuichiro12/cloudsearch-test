FROM alpine:latest AS base
RUN apk add --no-cache ca-certificates
COPY ./build/bin /usr/local/bin
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
