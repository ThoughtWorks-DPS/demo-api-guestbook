REGISTRY := ghcr.io/thoughtworks-dps
IMAGE := demo-api-guestbook

OS ?= $(shell uname)
ARCH ?= $(shell uname -m)

GOOS ?= $(shell echo "$(OS)" | tr '[:upper:]' '[:lower:]')
GOARCH_x86_64 = amd64
GOARCH_aarch64 = arm64
GOARCH_arm64 = arm64
GOARCH ?= $(shell echo "$(GOARCH_$(ARCH))")

REVISION := dev.$(shell echo $(CIRCLE_SHA1) | head -c 8)

OUTPUT_DIR := ./

.PHONY: build
build:
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(OUTPUT_DIR)/$(IMAGE)
	chmod +x $(OUTPUT_DIR)/$(IMAGE)
	docker build -t $(REGISTRY)/$(IMAGE):$(REVISION) .

.PHONY: push
push:
	docker push $(REGISTRY)/$(IMAGE):$(REVISION)




# .PHONY: environment local localredis clean

# # generate a local tag based on last SHA + last revision number
# LASTSHA := $(shell git rev-parse HEAD | cut -c 1-8)
# NEXTREVISION := $(shell expr $(shell helm history guestbook --namespace=blue-local --max=1 -o json | jq '.[].revision') + 1)
# LOCALVERSION?=local.${LASTSHA}.${NEXTREVISION}

# REGISTRY?=localhost:5000

# environment:
# 	@echo 'LASTSHA: ${LASTSHA}'
# 	@echo 'NEXTREVISION: ${NEXTREVISION}'
# 	@echo 'LOCALVERSION: ${LOCALVERSION}'
# 	@echo 'REGISTRY: ${REGISTRY}'

# # builds a docker image that builds the app and packages it into a minimal docker image
# local:
# 	docker build -t ${REGISTRY}/guestbook:${LOCALVERSION} .
# 	docker push ${REGISTRY}/guestbook:${LOCALVERSION}
# 	helm upgrade guestbook charts/guestbook --install --namespace=blue-local --set version=${LOCALVERSION}

# localredis:
# 	helm install redis charts/redis --namespace=blue-local --set version=v1.0.0

# clean:
# 	helm uninstall guestbook --namespace=blue-local
# 	helm uninstall redis --namespace=blue-local


