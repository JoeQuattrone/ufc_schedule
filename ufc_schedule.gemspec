
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ufc_schedule/version"

Gem::Specification.new do |spec|
  spec.name          = "ufc_schedule"
  spec.version       = UfcSchedule::VERSION
  spec.authors       = ["Joe Quattrone"]
  spec.email         = ["joequattrone5@gmail.com"]

  spec.summary       = %q{This is a gem that will allow you to view the Ultimate Fighting Championship (UFC) schedule as well as statistics related to the scheduled fights}
  spec.homepage      = "https://github.com/JoeQuattrone/ufc_schedule"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'pry'
  spec.add_dependency 'nokogiri', '1.6.6.2'
  spec.add_dependency 'json'
  spec.add_dependency 'rest-client'

end
