.PHONY: build

build-local:
	# multi-stage builds 🐳
	DOCKER_BUILDKIT=1 docker build -t cloudsearch-test-local --target local .
run-local:
	docker run -d --name cloudsearch-test-local -p 8080:8080 \
	-e CLOUDSEARCHDOMAIN_SEARCH_ENDPOINT=$(CLOUDSEARCHDOMAIN_SEARCH_ENDPOINT) \
	-e CLOUDSEARCHDOMAIN_DOCUMENT_ENDPOINT=$(CLOUDSEARCHDOMAIN_DOCUMENT_ENDPOINT) \
	cloudsearch-test-local
build-dev:
	# multi-stage builds 🐳
	DOCKER_BUILDKIT=1 docker build -t cloudsearch-test:latest --target dev .
tag:
	docker tag cloudsearch-test:latest 278038480382.dkr.ecr.us-west-1.amazonaws.com/cloudsearch-test:latest
push:
	docker push 278038480382.dkr.ecr.us-west-1.amazonaws.com/cloudsearch-test:latest
