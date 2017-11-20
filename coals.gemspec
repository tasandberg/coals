
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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = ['coals']
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16.a"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.1.0"
end
