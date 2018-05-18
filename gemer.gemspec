lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gemer/version'

Gem::Specification.new do |spec|
  spec.name          = 'gemer'
  spec.version       = Gemer::VERSION
  spec.authors       = ['Michael Kelly']
  spec.email         = ['michaelkelly322@gmail.com']

  spec.summary       = 'Provides useful Ruby library/module tools'
  spec.description   = 'Provides useful Ruby library/module tools'
  spec.homepage      = 'https://github.com/thebadmonkeydev/gemer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.0'
end
