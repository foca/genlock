GEMS = example/gems

.PHONY: all
all: example/Gemfile example/Gemfile.lock

.PHONY: clean
clean:
	rm -f example/Gemfile*

example/Gemfile.lock: $(GEMS)
	genlock $< > $@

example/Gemfile: $(GEMS)
	echo "source \"https://rubygems.org\"" > $@
	echo "ruby \"$(shell ruby -e 'puts RUBY_VERSION')\"" >> $@
	awk '{ print "gem \"" $$1 "\", \"" $$3 "\"" }' $< >> $@
