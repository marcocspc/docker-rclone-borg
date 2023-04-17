#check if docker compose or docker-compose
DOCKER_COMPOSE:=$(shell which docker-compose || echo 'docker compose')
RCLONE:=$(shell which rclone)

#include envfile
include ./borgmatic-rclone.env

.PHONY: all
all:
	$(DOCKER_COMPOSE) build

.PHONY: info
info:
	@echo "make info: shows this message"
	@echo "make: builds image"
	@echo "make rclone-config: generates rclone.config"
	@echo "make borg-repo: mounts remote and creates borg repository within. rclone.conf must be already created. Defaults to repokey enctryption."
	@echo "make shell: runs a shell inside the container for testing purposes."
	@echo "make config-files: generate needed files."
	@echo "make run: run the container."
	@echo "make run-dettached: run the container in the background."

.PHONY: rclone-config
rclone-config:
	@mkdir -p ./rclone
	$(RCLONE) --config ./rclone/rclone.conf config

.PHONY: borg-repo
borg-repo:
	$(DOCKER_COMPOSE) run -it borgmatic-rclone \
		/bin/ash -c "/usr/bin/rclone mount \
		'${REMOTE}:${PATH_TO_FILES}' /rclone/mount --daemon && \
		/usr/bin/borg init --encryption repokey /rclone/mount"

.PHONY: shell
shell:
	$(DOCKER_COMPOSE) run -it borgmatic-rclone /bin/ash

.PHONY: config-files
config-files:
	cp borgmatic-rclone.env.example borgmatic-rclone.env
	cp borgmatic.conf.yaml.example borgmatic.conf.yaml
	cp crontab.txt.example crontab.txt

.PHONY: run
run:
	$(DOCKER_COMPOSE) up

.PHONY: run-dettached
run-dettached:
	$(DOCKER_COMPOSE) up -d
