.PHONY: all build config run

NETWORK_NAME := rowlands.io

DIR := `pwd`
TINC_CONTAINER_NAME := tinc

ifeq ($(DEV_MODE),true)
  DEVELOPMENT_VOLUMES = \
    -v $(DIR)/keygen.sh:/usr/local/bin/keygen.sh \
    -v $(DIR)/entrypoint.sh:/usr/local/bin/entrypoint.sh \
    -v $(DIR)/jgrowl.configure_tinc:/etc/ansible/roles/jgrowl.configure_tinc
else
  DEVELOPMENT_VOLUMES =
endif

all: run

build:
	docker build -t jgrowl/tinc .

keygen: build
	docker run --rm -it $(DEVELOPMENT_VOLUMES) jgrowl/tinc keygen

run: build
	NETWORK_NAME=$(NETWORK_NAME) \
	docker run --rm -it --name=$(TINC_CONTAINER_NAME) \
	--device=/dev/net/tun \
	--cap-add NET_ADMIN \
	-e NETWORK_NAME \
	jgrowl/tinc -D -d 5 -n $(NETWORK_NAME)

clean-container:
	docker rm -f $(TINC_CONTAINER_NAME) ||:

clean: clean-container
	docker rmi jgrowl/tinc

