ROOT_DIR	:= $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
S3_BUCKET	:= ${S3_BUCKET}

.PHONY: test
test:
	pip install pyyaml==5.4.1
	python -m unittest discover tests

.PHONY: deploy
deploy: test
	aws s3 cp ./apps.yml s3://$(S3_BUCKET) --acl public-read --cache-control "no-cache"
