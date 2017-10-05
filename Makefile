.PHONY: build run help

.DEFAULT_GOAL =  help

## Build tmate image
build:
	@docker build -t denibertovic/tmate .

## Run tmate container
run:
	@if test -z "$$WORKDIR"; then echo "ERROR: WORKDIR is not defined."; exit 1; fi;
	@docker run -it -v $$WORKDIR:/opt/workdir -e LOCAL_USER_ID=1000 denibertovic/tmate bash

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

