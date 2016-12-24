EXAMPLE_GEMS = example/gems

-include config.mk

PACKAGES := genlock
VERSION_FILE := lib/genlock/version.rb

VERSION := $(shell sed -ne '/.*VERSION *= *"\(.*\)".*/s//\1/p' <$(VERSION_FILE))
GEMS := $(addprefix pkg/, $(addsuffix -$(VERSION).gem, $(PACKAGES)))

.PHONY: all
all: example/Gemfile example/Gemfile.lock $(GEMS)

.PHONY: clean
clean:
	rm -f example/Gemfile*
	rm -f pkg/*.gem

.PHONY: install
install:
	install -d $(PREFIX)/bin
	install bin/genlock $(PREFIX)/bin

.PHONY: example
example: example/Gemfile example/Gemfile.lock

example/Gemfile.lock: $(EXAMPLE_GEMS)
	genlock $< > $@

example/Gemfile: $(EXAMPLE_GEMS)
	echo "source \"https://rubygems.org\"" > $@
	echo "ruby \"$(shell ruby -e 'puts RUBY_VERSION')\"" >> $@
	awk '{ print "gem \"" $$1 "\", \"" $$3 "\"" }' $< >> $@

release: $(GEMS)
	for gem in $^; do gem push $$gem; done

pkg/%-$(VERSION).gem: %.gemspec $(VERSION_FILE) | pkg
	gem build $<
	mv $(@F) pkg/

pkg:
	mkdir -p $@
