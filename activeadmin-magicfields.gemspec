$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activeadmin-magicfields/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.license     = "MIT"
  s.name        = "activeadmin-magicfields"
  s.version     = ActiveadminMagicfields::VERSION
  s.authors     = ["Silvain Toromanoff"]
  s.email       = ["silvain@agencyleroy.com"]
  s.description = 'This gem extends formtastic\'s form builder to support custom fields and sections for your Active Admin models'
  s.summary     = 'Custom fields and sections for active admin.'
  s.homepage    = "https://github.com/Silvaire/activeadmin-magicfields"

  s.files         = `git ls-files`.split("\n").sort
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")

  s.add_dependency "activeadmin"
  s.add_dependency "inherited_resources"
  s.add_dependency "paperclip"
end
