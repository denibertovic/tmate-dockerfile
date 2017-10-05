.PHONY: build run help

.DEFAULT_GOAL =  help

IMAGE_NAME := denibertovic/tmate
LOCAL_USER_ID ?= $(shell id -u $$USER)

## Build tmate image
build:
	@docker build -t ${IMAGE_NAME} .

## Run tmate container
run:
	@if test -z "$$WORKDIR"; then echo "ERROR: WORKDIR is not defined."; exit 1; fi;
	@docker run -it -v $$WORKDIR:/opt/workdir -e LOCAL_USER_ID=${LOCAL_USER_ID} ${IMAGE_NAME} bash

## Show help screen.
help:
	@echo "Please use \`make <target>' where <target> is one of\n\n"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "%-30s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

