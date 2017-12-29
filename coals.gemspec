
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "coals/version"

Gem::Specification.new do |spec|
  spec.name          = "coals"
  spec.version       = Coals::VERSION
  spec.authors       = ["Tim Sandberg"]
  spec.email         = ["tasandberg@gmail.com"]

  spec.summary       = %q{An interactive rake task runner}
  spec.description   = %q{
    When run in a ruby project, Coals provides an interactive interface for calling rake tasks with the appropriate
    arguments. Some features include:
    * Setting the execution prefix of your choice, i.e. 'rake', 'bundle exec rake', 'bin/remote-rake development', etc.
    * Set aliases for common values: `coals --alias me jimbo@springfield-high.edu`
    * Review and confirm command before running.
  }
  spec.homepage      = "http://github.com/Timmehs/coals"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb']
  spec.bindir        = "bin"
  spec.executables   = ['coals']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.7.0"
  spec.add_development_dependency "pry", "~> 0.11.3"
  spec.add_development_dependency "pry-byebug", "~> 3.5.1"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
