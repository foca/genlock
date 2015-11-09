# Generate Gemfile.lock from a `.gems` file

If you use any of the utilities that manage `.gems` file for ruby instead of
bundler (such as [dep][], [rpm][], or similar tools), and want to use tools that
assume you use Bundler (for example, deploying to Heroku), you can easily
generate a `Gemfile.lock` file from your `.gems` file using this tool.

This is what I put in my `Makefile`:

``` Makefile
Gemfile: .gems
	echo "source \"https://rubygems.org\"" > $@
	echo "ruby \"$(shell ruby -e 'puts RUBY_VERSION')\"" >> $@
	awk '{ print "gem \"" $$1 "\", \"" $$3 "\"" }' $< >> $@

Gemfile.lock: .gems
	genlock $< > $@
```

Now, whenever my `.gems` file changes, `make` will ensure I have the `Gemfile`
and `Gemfile.lock` files available for whatever tools that require them.

## Installation

Clone the repository, then run `make install`. You can run `./configure --prefix
<prefix>` if you want to change the install location (by default `/usr/local`).

...Or you can download the binary and drop it in your PATH, really. No need for
anything fancy :)

## License

Distributed under an MIT license. See the [LICENSE](./LICENSE) file for details.

[dep]: https://github.com/djanowski/dep
[rpm]: https://github.com/elcuervo/rpm
