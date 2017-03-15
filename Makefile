.PHONY: help

APP ?= test
VERSION ?= `cat VERSION`
IMAGE_NAME ?= bitwalker/$(APP)
PWD ?= `pwd`

help:
	@echo "$(IMAGE_NAME):$(VERSION)"
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

test: ## Test the Docker image
	docker run --rm -it $(IMAGE_NAME):$(VERSION) erl -version

shell: ## Run an Erlang shell in the image
	docker run --rm -it $(IMAGE_NAME):$(VERSION) erl

run: ## Run the app in the image
	docker run --rm -it $(IMAGE_NAME):$(VERSION)

build: releases/test.tar.gz ## Rebuild the Docker image
	docker build --build-arg APP=$(APP) --force-rm -t $(IMAGE_NAME):$(VERSION) -t $(IMAGE_NAME):latest .

releases/test.tar.gz:
	docker run -it -e APP=$(APP) -e VERSION=$(VERSION) -v $(PWD):/opt/build bitwalker/alpine-elixir:latest /bin/sh -c '. /opt/build/bin/build.sh'

release: build ## Rebuild and release the Docker image to Docker Hub
	docker push $(IMAGE_NAME):$(VERSION)
	docker push $(IMAGE_NAME):latest
