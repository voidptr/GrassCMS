# Makefile for grasscms persistence plugin

all: build_ compress

compress: build
	yui-compressor --type js build/js/grasscms.js > build/js/grasscms.min.js
	yui-compressor --type css build/css/grasscms.css > build/css/grasscms.min.css

build_:
	mkdir -p build/js build/css &>/dev/null
	coffee --join build/js/grasscms.js --compile coffee/*.coffee
	lessc less/main.less build/css/grasscms.css
	cp -r vendor/editor/less/font-awesome/font/ build/

clean:
	rm -rf build/js/grasscms* build/css/grasscms*

.PONY: clean build compress all
