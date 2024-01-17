name := tex

build:
	docker build -t $(IMAGE_NAME) .

