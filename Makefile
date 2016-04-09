.PHONY: all build run

DIR := `pwd`
ENVIRONMENT := production
DEV_MODE=true
SKIP_TAGS_ARGS=--skip-tags 'development_push_build'
#SKIP_TAGS_ARGS=

LIMIT_ARGS=
#LIMIT_ARGS=--limit flocker

PLAYBOOK=/etc/ansible/site.yml
#PLAYBOOK=/etc/ansible/flocker.yml

LOG_LEVEL=-vvvv
IMAGE_NAME=jgrowl/bootstrap

HOST_UID := $(shell id -u)
HOST_GID= $(shell id -g)

ifeq ($(DEV_MODE),true)
  DEVELOPMENT_VOLUMES = \
	-v $(echo $HOME)/.docker:$(echo $HOME)/.docker \
	-v $(DIR)/lib/docker-machine-py/docker_machine:/opt/ansible/ansible/lib/docker_machine \
	-v $(DIR)/lib/ansible-docker-machine/module_utils/docker_machine.py:/opt/ansible/ansible/lib/ansible/module_utils/docker_machine.py \
	-v $(DIR)/lib/ansible-docker-machine/library/docker_machine:/opt/ansible/ansible/library/docker_machine \
	-v $(DIR)/lib/ansible-docker-machine/library:/opt/ansible/ansible/library \
	-v $(DIR)/lib/ansible-docker-machine/connection_plugins/docker_machine.py:/usr/share/ansible/plugins/connection/docker_machine.py \
	-v $(DIR)/lib/ansible-docker-machine/lookup_plugins/docker_machine.py:/usr/share/ansible/plugins/lookup/docker_machine.py \
	-v /home/jgrowlands/Code/go-projects/src/github.com/docker/machine/bin/docker-machine:/usr/local/bin/docker-machine \
	-v $(DIR)/site.yml:/etc/ansible/site.yml \
	-v $(DIR)/playbooks:/etc/ansible/playbooks \
	-v $(DIR)/images/tinc:/etc/ansible/tinc \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /var/lib/docker:/var/lib/docker
else
  DEVELOPMENT_VOLUMES =
endif

all: run

build:
	docker build -t $(IMAGE_NAME) .

run: build
	SHELL='sh' \
	MACHINE_STORAGE_PATH=/docker/.docker \
	HOST_UID=$(HOST_UID) \
	HOST_GID=$(HOST_GID) \
	docker run --rm -it --name=site_bootstrap \
	-e SHELL \
	-e MACHINE_STORAGE_PATH \
	-e HOST_UID \
	-e HOST_GID \
	$(DEVELOPMENT_VOLUMES) \
	-v $(DIR)/.private:/docker \
	jgrowl/bootstrap $(LOG_LEVEL) $(PLAYBOOK) -i /etc/ansible/inventories/$(ENVIRONMENT) $(SKIP_TAGS_ARGS) $(LIMIT_ARGS)


sh: build
	HOST_UID=$(echo $HOST_UID) \
	SHELL='sh' \
	MACHINE_STORAGE_PATH=$(echo $HOME)/.docker \
	HOST_UID=$(HOST_UID) \
	HOST_GID=$(HOST_GID) \
	docker run --rm -it --name=site_bootstrap_sh \
	-e SHELL \
	-e MACHINE_STORAGE_PATH \
	-e HOST_UID \
	-e HOST_GID \
	$(DEVELOPMENT_VOLUMES) \
	-v $(DIR)/.private:/docker \
	$(IMAGE_NAME) sh $(LOG_LEVEL) $(PLAYBOOK) -i /etc/ansible/inventories/$(ENVIRONMENT) $(SKIP_TAGS_ARGS) $(LIMIT_ARGS)