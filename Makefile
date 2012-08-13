.PHONY: build test node clean purge help node

ALL_LIB := $(shell find src -type d)
ALL_LIB := $(ALL_LIB:src%=lib/coffee-script%)

ALL_CDENT := $(shell find src -name *.uni)
ALL_JS := $(ALL_CDENT:src/%.uni=lib/coffee-script/%.js)
PARSER_JS := lib/coffee-script/parser.js

default: help

help:
	@echo ''
	@echo 'Makefile targets:'
	@echo ''
	@echo '    make build   - Compile stuff'
	@echo '    make test    - Run the tests'
	@echo '    make install - Install into NPM'
	@echo ''
	@echo '    make node    - Make a Node.js package'
	@echo ''
	@echo '    make clean   - Clean up'
	@echo '    make help    - Get Help'
	@echo ''

build: $(ALL_LIB) $(ALL_JS) $(PARSER_JS)

$(PARSER_JS):
	./bin/jison-generate-parser > $@

lib/coffee-script/%.js: src/%.uni
	coffee --compile -p $< > $@

test xtest: build
	cake test
	# coffee -e '(require "./test/lib/Test/Harness").run()' $@

install: node
	(cd $<; npm install)

node: clean build
	mkdir -p $@
	cp -r \
	    LICENSE* \
	    README* \
	    lib \
	    $@/
	./bin/cdent-package-yaml-converter package.yaml > $@/package.json

clean purge:
	rm -fr node_modules lib node
	@# make -C test $@

$(ALL_LIB):
	mkdir -p $@
