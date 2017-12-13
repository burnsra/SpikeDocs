SHELL := /bin/bash
BUNDLE := bundle
YARN := yarn
VENDOR_DIR = assets/vendor/
JEKYLL := $(BUNDLE) exec jekyll

PROJECT_DEPS := Gemfile package.json

.PHONY: all clean install update

all : serve

install: $(PROJECT_DEPS)
	$(BUNDLE) install --path vendor/bundler
	$(YARN) install

update: $(PROJECT_DEPS)
	$(BUNDLE) update
	$(YARN) upgrade

include-yarn-deps:
	mkdir -p $(VENDOR_DIR)
	cp node_modules/font-awesome/fonts/fontawesome-webfont.* $(VENDOR_DIR)
	cp -R node_modules/highlight.js/lib/* $(VENDOR_DIR)
	cp node_modules/highlight.js/styles/atom-one-light.css $(VENDOR_DIR)

build: install include-yarn-deps
	$(JEKYLL) build

serve: install include-yarn-deps
	JEKYLL_ENV=production $(JEKYLL) serve
