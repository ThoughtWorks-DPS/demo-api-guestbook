# Copyright 2016 The Kubernetes Authors. 
#  with modifications
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.PHONY: environment local localredis clean

# generate a local tag based on last SHA + last revision number
LASTSHA := $(shell git rev-parse HEAD | cut -c 1-8)
NEXTREVISION := $(shell expr $(shell helm history guestbook --namespace=blue-local --max=1 -o json | jq '.[].revision') + 1)
LOCALVERSION?=local.${LASTSHA}.${NEXTREVISION}

REGISTRY?=localhost:5000

environment:
	@echo 'LASTSHA: ${LASTSHA}'
	@echo 'NEXTREVISION: ${NEXTREVISION}'
	@echo 'LOCALVERSION: ${LOCALVERSION}'
	@echo 'REGISTRY: ${REGISTRY}'

# builds a docker image that builds the app and packages it into a minimal docker image
local:
	docker build -t ${REGISTRY}/guestbook:${LOCALVERSION} .
	docker push ${REGISTRY}/guestbook:${LOCALVERSION}
	helm upgrade guestbook charts/guestbook --install --namespace=blue-local --set version=${LOCALVERSION}

localredis:
	helm install redis charts/redis --namespace=blue-local --set version=v1.0.0

clean:
	helm uninstall guestbook --namespace=blue-local
	helm uninstall redis --namespace=blue-local


