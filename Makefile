REGISTRY := ghcr.io/thoughtworks-dps
IMAGE := demo-api-guestbook

GOOS ?= $(shell echo "$(shell uname)" | tr '[:upper:]' '[:lower:]')
GOARCH_amd64 = amd64
GOARCH_x86_64 = amd64
GOARCH_aarch64 = arm64
GOARCH_arm64 = arm64
GOARCH ?= $(shell echo "$(GOARCH_$(shell uname -m))")
OUTPUT_DIR := ./
REVISION := dev.$(shell echo $(CIRCLE_SHA1) | head -c 8)
ifndef CIRCLE_SHA1
  REVISION := local
endif

$(info $$REGISTRY is [${REGISTRY}])
$(info $$IMAGE is [${IMAGE}])
$(info $$GOOS is [${GOOS}])
$(info $$GOARCH is [${GOARCH}])
$(info $$REVISION is [${REVISION}])

.PHONY: build
build:
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -o $(OUTPUT_DIR)/$(IMAGE)
	chmod +x $(OUTPUT_DIR)/$(IMAGE)
	docker build -t $(REGISTRY)/$(IMAGE):$(REVISION) .

.PHONY: push
push:
	docker push $(REGISTRY)/$(IMAGE):$(REVISION)
