SPEC_DIR = File.dirname __FILE__

require 'rubygems'
require 'bundler/setup'
require 'bogus/rspec'
require 'debugger'
require 'duke_of_url'
require 'factory_girl'
require 'faker'
require 'letters'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/patches/'
end

Dir.glob("#{SPEC_DIR}/support/**/*.rb").each {|f| require f}

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

Bogus.configure do |c|
  c.search_modules << DukeOfUrl
end
