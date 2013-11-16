# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nifval/version"

Gem::Specification.new do |s|
  s.name        = "nifval"
  s.version     = NifVal::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Albert Bellonch"]
  s.email       = ["albert@itnig.net"]
  s.homepage    = "https://github.com/albertbellonch/nifval"
  s.summary     = %q{Validates a Spanish NIF/CIF/NIE}
  s.description = %q{Validates a Spanish NIF/CIF/NIE by verifying that the control character corresponds to the number.}

  s.rubyforge_project = "nifval"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.5"
  s.add_development_dependency "fuubar"
  s.add_development_dependency "activemodel"
  s.add_dependency "i18n"
end
