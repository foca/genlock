require "./lib/genlock/version"

Gem::Specification.new do |s|
  s.name        = "genlock"
  s.licenses    = ["MIT"]
  s.version     = Genlock::VERSION
  s.summary     = "Genlock: Generate Gemfile.lock files without Bundler"
  s.description = "Genlock generates Gemfile.lock files from .gems files without the need for Bundler"
  s.authors     = ["Nicolas Sanguinetti"]
  s.email       = ["contacto@nicolassanguinetti.info"]
  s.homepage    = "http://github.com/foca/genlock"

  s.files = Dir[
    "LICENSE",
    "README.md",
    "bin/genlock",
    "lib/genlock.rb",
    "lib/genlock/version.rb",
  ]
end
