# -*- encoding: utf-8 -*-
# stub: duke_of_url 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "duke_of_url"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Martin Streicher"]
  s.date = "2014-02-25"
  s.description = "Normalize and SHA1-encode URLs"
  s.email = ["mstreicher@rentpath.com"]
  s.files = [".gitignore", ".rspec", ".ruby-gemset", ".ruby-version", "Gemfile", "Gemfile.lock", "LICENSE.md", "README.md", "Rakefile", "duke_of_url.gemspec", "lib/duke_of_url.rb", "lib/duke_of_url/normalizer.rb", "lib/duke_of_url/sha1.rb", "lib/duke_of_url/util/version.rb", "spec/lib/duke_of_url/normalizer_spec.rb", "spec/lib/duke_of_url/sha1_spec.rb", "spec/spec_helper.rb", "vendor/cache/activesupport-4.0.2.gem", "vendor/cache/addressable-2.3.5.gem", "vendor/cache/atomic-1.1.14.gem", "vendor/cache/awesome_print-1.2.0.gem", "vendor/cache/bogus-0.1.4.gem", "vendor/cache/builder-3.2.2.gem", "vendor/cache/cane-2.6.1.gem", "vendor/cache/celluloid-0.15.2.gem", "vendor/cache/cheat-1.3.3.gem", "vendor/cache/coderay-1.1.0.gem", "vendor/cache/colorize-0.6.0.gem", "vendor/cache/columnize-0.3.6.gem", "vendor/cache/debugger-1.6.3.gem", "vendor/cache/debugger-linecache-1.2.0.gem", "vendor/cache/debugger-ruby_core_source-1.2.4.gem", "vendor/cache/dependor-1.0.1.gem", "vendor/cache/diff-lcs-1.2.5.gem", "vendor/cache/docile-1.1.1.gem", "vendor/cache/factory_girl-4.3.0.gem", "vendor/cache/faker-1.2.0.gem", "vendor/cache/ffi-1.9.3.gem", "vendor/cache/formatador-0.2.4.gem", "vendor/cache/geminabox-0.12.1.gem", "vendor/cache/grb-0.4.1.gem", "vendor/cache/guard-2.2.4.gem", "vendor/cache/guard-rspec-4.2.0.gem", "vendor/cache/hashie-2.0.5.gem", "vendor/cache/httpclient-2.3.4.1.gem", "vendor/cache/i18n-0.6.9.gem", "vendor/cache/letters-0.4.1.gem", "vendor/cache/listen-2.4.0.gem", "vendor/cache/lumberjack-1.0.4.gem", "vendor/cache/method_source-0.8.2.gem", "vendor/cache/minitest-4.7.5.gem", "vendor/cache/multi_json-1.8.2.gem", "vendor/cache/nesty-1.0.2.gem", "vendor/cache/nokogiri-1.5.10.gem", "vendor/cache/pager-1.0.1.gem", "vendor/cache/parallel-0.9.1.gem", "vendor/cache/postrank-uri-1.0.17.gem", "vendor/cache/primedia-0.0.3.gem", "vendor/cache/pry-0.9.12.4.gem", "vendor/cache/public_suffix-1.1.3.gem", "vendor/cache/rack-1.5.2.gem", "vendor/cache/rack-protection-1.5.1.gem", "vendor/cache/rack-test-0.6.2.gem", "vendor/cache/rake-10.1.0.gem", "vendor/cache/rb-fsevent-0.9.3.gem", "vendor/cache/rb-inotify-0.9.2.gem", "vendor/cache/rspec-2.14.1.gem", "vendor/cache/rspec-core-2.14.7.gem", "vendor/cache/rspec-expectations-2.14.4.gem", "vendor/cache/rspec-mocks-2.14.4.gem", "vendor/cache/simplecov-0.8.2.gem", "vendor/cache/simplecov-html-0.8.0.gem", "vendor/cache/sinatra-1.4.4.gem", "vendor/cache/slop-3.4.7.gem", "vendor/cache/thor-0.18.1.gem", "vendor/cache/thread_safe-0.1.3.gem", "vendor/cache/tilt-1.4.1.gem", "vendor/cache/timers-1.1.0.gem", "vendor/cache/tzinfo-0.3.38.gem", "vendor/cache/vcr-2.8.0.gem", "vendor/cache/xml-simple-1.1.2.gem"]
  s.homepage = "http://github.com/primedia/duke_of_url"
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.2.2"
  s.summary = "Normalize and SHA1-encode URLs"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_runtime_dependency(%q<hashie>, ["~> 2.0"])
      s.add_runtime_dependency(%q<postrank-uri>, [">= 0"])
      s.add_development_dependency(%q<bogus>, [">= 0"])
      s.add_development_dependency(%q<cane>, [">= 0"])
      s.add_development_dependency(%q<cheat>, [">= 0"])
      s.add_development_dependency(%q<debugger>, [">= 0"])
      s.add_development_dependency(%q<factory_girl>, [">= 0"])
      s.add_development_dependency(%q<faker>, [">= 0"])
      s.add_development_dependency(%q<grb>, [">= 0"])
      s.add_development_dependency(%q<guard-rspec>, [">= 0"])
      s.add_development_dependency(%q<letters>, [">= 0"])
      s.add_development_dependency(%q<primedia>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<sinatra>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<hashie>, ["~> 2.0"])
      s.add_dependency(%q<postrank-uri>, [">= 0"])
      s.add_dependency(%q<bogus>, [">= 0"])
      s.add_dependency(%q<cane>, [">= 0"])
      s.add_dependency(%q<cheat>, [">= 0"])
      s.add_dependency(%q<debugger>, [">= 0"])
      s.add_dependency(%q<factory_girl>, [">= 0"])
      s.add_dependency(%q<faker>, [">= 0"])
      s.add_dependency(%q<grb>, [">= 0"])
      s.add_dependency(%q<guard-rspec>, [">= 0"])
      s.add_dependency(%q<letters>, [">= 0"])
      s.add_dependency(%q<primedia>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<hashie>, ["~> 2.0"])
    s.add_dependency(%q<postrank-uri>, [">= 0"])
    s.add_dependency(%q<bogus>, [">= 0"])
    s.add_dependency(%q<cane>, [">= 0"])
    s.add_dependency(%q<cheat>, [">= 0"])
    s.add_dependency(%q<debugger>, [">= 0"])
    s.add_dependency(%q<factory_girl>, [">= 0"])
    s.add_dependency(%q<faker>, [">= 0"])
    s.add_dependency(%q<grb>, [">= 0"])
    s.add_dependency(%q<guard-rspec>, [">= 0"])
    s.add_dependency(%q<letters>, [">= 0"])
    s.add_dependency(%q<primedia>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 0"])
  end
end
