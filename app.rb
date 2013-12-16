require 'slim'
require 'json'
require_relative 'app/models/screaming_frog'

require 'pry'
require 'pry-nav'

get "/" do
  slim :index
end

post '/work' do
  params = JSON.parse(request.env["rack.input"].read)
  content_type :json
  ScreamingFrog.process(params['url'], '/')
end
