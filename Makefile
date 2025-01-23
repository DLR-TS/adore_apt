SHELL:=/bin/bash

.DEFAULT_GOAL := all

ROOT_DIR:=$(shell dirname "$(realpath $(firstword $(MAKEFILE_LIST)))")

MAKEFLAGS += --no-print-directory

.EXPORT_ALL_VARIABLES:
DOCKER_BUILDKIT?=1
DOCKER_CONFIG?=

USER := $(shell whoami)
UID := $(shell id -u)
GID := $(shell id -g)
DOCKER_IMAGE := apt-repo-creator
DOCKERFILE := Dockerfile
SCRIPT := setup-apt-repo.sh


.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE) -f $(DOCKERFILE) .

.PHONY: run
run:
	docker run --rm -v $(ROOT_DIR):/repo $(DOCKER_IMAGE)

.PHONY: clean
clean:
	docker rmi $(DOCKER_IMAGE)
	rm -rf adore-apt-repo

.PHONY: all
all: build run

