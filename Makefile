BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
GIT_HASH = $(shell git show --format="%h" HEAD | head -1)
VERSION ?= latest

.PHONY: all server server-nls client client-vnc client-nls thin-client thin-client-nls crs rac-gui gitsync oscript oscript-utils runner

all: server client thin-client crs

all-my: server crs client client-vnc oscript runner gitsync

server:
	docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
		--build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		-t ${DOCKER_USERNAME}/onec-server:${ONEC_VERSION} \
		-f server/Dockerfile .
	docker tag ${DOCKER_USERNAME}/onec-server:${ONEC_VERSION} ${DOCKER_USERNAME}/onec-server:latest

server-nls:
	docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
		--build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		--build-arg nls_enabled=true \
		-t ${DOCKER_USERNAME}/onec-server-nls:${ONEC_VERSION} \
		-f server/Dockerfile .
	docker tag ${DOCKER_USERNAME}/onec-server-nls:${ONEC_VERSION} ${DOCKER_USERNAME}/onec-server-nls:latest

client:
	docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
		--build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		-t ${DOCKER_USERNAME}/onec-client:${ONEC_VERSION} \
		-f client/Dockerfile .
	docker tag ${DOCKER_USERNAME}/onec-client:${ONEC_VERSION} ${DOCKER_USERNAME}/onec-client:latest

client-vnc:
	docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		-t ${DOCKER_USERNAME}/onec-client-vnc:${ONEC_VERSION} \
		-f client-vnc/Dockerfile .
	docker tag ${DOCKER_USERNAME}/onec-client-vnc:${ONEC_VERSION} ${DOCKER_USERNAME}/onec-client-vnc:latest

client-nls:
	docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
		--build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		--build-arg nls_enabled=true \
		-t ${DOCKER_USERNAME}/onec-client-nls:${ONEC_VERSION} \
		-f client/Dockerfile .
	docker tag ${DOCKER_USERNAME}/onec-client-nls:${ONEC_VERSION} ${DOCKER_USERNAME}/onec-client-nls:latest

thin-client:
	docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
		--build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		-t ${DOCKER_USERNAME}/onec-thin-client:${ONEC_VERSION} \
		-f thin-client/Dockerfile .
	docker tag ${DOCKER_USERNAME}/onec-thin-client:${ONEC_VERSION} ${DOCKER_USERNAME}/onec-thin-client:latest

thin-client-nls:
	docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
		--build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		--build-arg nls_enabled=true \
		-t ${DOCKER_USERNAME}/onec-thin-client-nls:${ONEC_VERSION} \
		-f thin-client/Dockerfile .
	docker tag ${DOCKER_USERNAME}/onec-thin-client-nls:${ONEC_VERSION} ${DOCKER_USERNAME}/onec-thin-client-nls:latest

crs:
	docker build --build-arg ONEC_USERNAME=${ONEC_USERNAME} \
		--build-arg ONEC_PASSWORD=${ONEC_PASSWORD} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		-t ${DOCKER_USERNAME}/onec-crs:${ONEC_VERSION} \
		-f crs/Dockerfile .
	docker tag ${DOCKER_USERNAME}/onec-crs:${ONEC_VERSION} ${DOCKER_USERNAME}/onec-crs:latest

rac-gui:
	docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		-t ${DOCKER_USERNAME}/onec-rac-gui:${ONEC_VERSION}-1.0.1 \
		-f rac-gui/Dockerfile .
	docker tag ${DOCKER_USERNAME}/onec-rac-gui:${ONEC_VERSION}-1.0.1 ${DOCKER_USERNAME}/onec-rac-gui:latest

gitsync:
	docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		-t ${DOCKER_USERNAME}/gitsync:3.0.0 \
		-f gitsync/Dockerfile .
	docker tag ${DOCKER_USERNAME}/gitsync:3.0.0 ${DOCKER_USERNAME}/gitsync:latest

oscript:
	docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
		--build-arg ONEC_VERSION=${ONEC_VERSION} \
		-t ${DOCKER_USERNAME}/oscript:1.0.21 \
		-f oscript/Dockerfile .
	docker tag ${DOCKER_USERNAME}/oscript:1.0.21 ${DOCKER_USERNAME}/oscript:latest

oscript-utils:
	docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
		-t ${DOCKER_USERNAME}/oscript-utils:latest \
		-f oscript-utils/Dockerfile .

runner:
	docker build --build-arg DOCKER_USERNAME=${DOCKER_USERNAME} \
		-t ${DOCKER_USERNAME}/runner:1.7.0 \
		-f vanessa-runner/Dockerfile .
	docker tag ${DOCKER_USERNAME}/runner:1.7.0 ${DOCKER_USERNAME}/runner:latest
