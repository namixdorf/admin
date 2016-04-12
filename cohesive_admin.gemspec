$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cohesive_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cohesive_admin"
  s.version     = CohesiveAdmin::VERSION
  s.authors     = ["cohesiveneal"]
  s.email       = ["neal@cohesive.cc"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of CohesiveAdmin."
  s.description = "TODO: Description of CohesiveAdmin."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.6"
  # s.add_dependency "foundation-rails", ">= 6.2"
  s.add_dependency "sass-rails"
  s.add_dependency "compass-rails", ">= 3.0"
  s.add_dependency "coffee-rails"
  s.add_dependency "bcrypt-ruby", "~> 3.1.5"
  s.add_dependency 'jquery-rails', ['>= 3.0', '< 5']
  s.add_dependency 'jquery-ui-rails', '~> 5.0'

  s.add_dependency 'kaminari', '~> 0.14'
  s.add_dependency 'simple_form', '~> 3.1'

  s.add_development_dependency "sqlite3"
end
