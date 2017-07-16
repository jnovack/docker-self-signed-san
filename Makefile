.PHONY: build run exec all

all: build run

build:
	docker rmi jnovack/self-signed-san || true
	docker build -t jnovack/self-signed-san .

run:
	docker run -it --rm jnovack/self-signed-san

exec:
	docker run -it --rm --entrypoint=/bin/sh jnovack/self-signed-san
