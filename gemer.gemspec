lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gemer/version'

Gem::Specification.new do |s|
  s.name          = 'gemer'
  s.version       = Gemer::VERSION
  s.authors       = ['Michael Kelly']
  s.email         = ['michaelkelly322@gmail.com']

  s.summary       = 'Provides useful Ruby library/module configuration tools'
  s.description   = 'Provides useful Ruby library/module configuration tools'
  s.homepage      = 'https://github.com/thebadmonkeydev/gemer'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir        = 'exe'
  s.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_ruby_version = '~> 1.9'

  s.add_development_dependency 'bundler', '~> 1.16'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake',    '~> 10.0'
  s.add_development_dependency 'rspec',   '~> 3.0'
end
