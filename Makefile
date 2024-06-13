SHELL = /bin/sh
CURRENT_UID := $(shell id -u)
ifneq ($(shell docker compose version 2>/dev/null),)
  DOCKER_COMPOSE=docker compose
else
  DOCKER_COMPOSE=docker-compose
endif

rebuild:
	$(DOCKER_COMPOSE) build --no-cache --build-arg DEV=true

shell:
	$(DOCKER_COMPOSE) run jupyter

jupyter:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down
