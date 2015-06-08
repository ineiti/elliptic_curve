# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elliptic_curve/version'

Gem::Specification.new do |spec|
  spec.name = 'elliptic_curve'
  spec.version = EllipticCurve::VERSION
  spec.authors = ['Linus Gasser']
  spec.email = ['ineiti@linusetviviane.ch']

  spec.summary = %q{Simple implementation of the basic functionalities for working with
                          elliptic curves. }
  spec.description = %q{This gives the basic for representing elliptic curves of the form
y^2 = x^3 + ax + b, including adding and (p^-1 modulo q).}
  spec.homepage = 'http://github.com/ineiti/elliptic_curve'
  spec.license = 'GPL-3.0'


  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
end
