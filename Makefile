tag ?= latest
image := mmngreco/dex
image_tag := $(image):$(tag)
user := $(shell id -u):$(shell id -g)
pwd := $(shell pwd)

.PHONY: build
build:
	docker build -t $(image_tag) .
	docker build -t $(image_tag) .

.PHONY: push
push:
	docker push $(image_tag)
	docker push $(image):latest

.PHONY: test
test:
	docker run \
		--rm -t \
		--user="$(user)" \
		--net=none \
		-v "$(pwd):/data" \
		$(tag) texliveonfly test/test.tex

.PHONY: clean
clean:
	git clean -fdx

.PHONY: info
info:
	@echo user=$(user)
	@echo pwd=$(pwd)
	@echo tag=$(tag)
	@echo image=$(image)
