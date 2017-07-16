.PHONY: build run exec push dev all

all: build run

dev: build exec

build:
	docker rmi jnovack/self-signed-san || true
	docker build -t jnovack/self-signed-san .

run:
	docker run -it --rm jnovack/self-signed-san

exec:
	docker run -it --rm --entrypoint=/bin/sh jnovack/self-signed-san

push: build
	docker push jnovack/self-signed-san