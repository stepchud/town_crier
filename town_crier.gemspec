$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "town_crier/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "town_crier"
  s.version     = TownCrier::VERSION
  s.authors     = ["Stephen Chudleigh"]
  s.email       = ["stephen@stephenchudleigh.com"]
  s.homepage    = "https://github.com/stepchud/town_crier"
  s.summary     = "Town Crier is a Rails Engine that makes easy to notify Users."
  s.description = %q{
    The idea of Town Crier is to handle messaging your users via various methods: SMS, MMS, Email, Mobile, etc.
  }

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency "rails", "~> 4.0.3"
  s.add_runtime_dependency "sms_fu", ">= 1.2.0"
  s.add_runtime_dependency "sass-rails"
  s.add_runtime_dependency "bootstrap-sass"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "factory_girl"
end
