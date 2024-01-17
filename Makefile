tag := dex
user := $(shell id -u):$(shell id -g)
pwd := $(shell pwd)

.PHONY: build
build:
	docker build -t $(tag) .

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
