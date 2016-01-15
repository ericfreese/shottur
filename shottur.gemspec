# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shottur/version'

Gem::Specification.new do |spec|
  spec.name          = 'shottur'
  spec.version       = Shottur.version
  spec.authors       = ['Eric Freese']
  spec.email         = ['ericdfreese@gmail.com']

  spec.summary       = 'Screenshot uploader'
  spec.description   = 'Watches for new screenshots, uploads them to Imgur, and copies the URL to the clipboard.'
  spec.homepage      = 'https://github.com/ericfreese/shottur'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^test/})
  end

  spec.bindir        = 'bin'
  spec.executables   = ['shottur']
  spec.require_paths = ['lib']

  spec.add_dependency               'trollop',       '~> 2.1'
  spec.add_dependency               'filewatcher',   '~> 0.5'
  spec.add_dependency               'imgur-api',     '~> 0.0.4'
  spec.add_dependency               'spotlight',     '~> 0.0.6'

  spec.add_development_dependency   'bundler',       '~> 1.11'
  spec.add_development_dependency   'rake',          '~> 10.0'
  spec.add_development_dependency   'minitest',      '~> 5.0'
end
