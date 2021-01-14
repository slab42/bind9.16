all: build

build:
	@docker build --tag=slab42/bind9.16:arm64v8 .
