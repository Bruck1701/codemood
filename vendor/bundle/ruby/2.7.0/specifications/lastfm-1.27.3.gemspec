# -*- encoding: utf-8 -*-
# stub: lastfm 1.27.3 ruby lib

Gem::Specification.new do |s|
  s.name = "lastfm".freeze
  s.version = "1.27.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["youpy".freeze]
  s.date = "2019-03-13"
  s.description = "A ruby interface for Last.fm web services version 2.0".freeze
  s.email = ["youpy@buycheapviagraonlinenow.com".freeze]
  s.homepage = "http://github.com/youpy/ruby-lastfm".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "A ruby interface for Last.fm web services version 2.0".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<xml-simple>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<httparty>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 2.8.0"])
    s.add_development_dependency(%q<rake>.freeze, ["< 11.0"])
  else
    s.add_dependency(%q<xml-simple>.freeze, [">= 0"])
    s.add_dependency(%q<httparty>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.8.0"])
    s.add_dependency(%q<rake>.freeze, ["< 11.0"])
  end
end
