# -*- encoding: utf-8 -*-
# stub: robotex 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "robotex"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Kite"]
  s.date = "2012-01-20"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc"]
  s.homepage = "http://www.github.com/chriskite/robotex"
  s.rdoc_options = ["-m", "README.rdoc", "-t", "Robotex"]
  s.rubygems_version = "2.2.2"
  s.summary = "Obey Robots.txt"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0.9.2"])
      s.add_development_dependency(%q<rdoc>, [">= 3.12"])
      s.add_development_dependency(%q<rspec>, [">= 2.8.0"])
      s.add_development_dependency(%q<fakeweb>, [">= 1.3.0"])
    else
      s.add_dependency(%q<rake>, [">= 0.9.2"])
      s.add_dependency(%q<rdoc>, [">= 3.12"])
      s.add_dependency(%q<rspec>, [">= 2.8.0"])
      s.add_dependency(%q<fakeweb>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.9.2"])
    s.add_dependency(%q<rdoc>, [">= 3.12"])
    s.add_dependency(%q<rspec>, [">= 2.8.0"])
    s.add_dependency(%q<fakeweb>, [">= 1.3.0"])
  end
end
