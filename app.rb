require 'slim'
require 'json'
require_relative 'app/models/url_stats'

post '/work' do
  params = JSON.parse(request.env["rack.input"].read)
  content_type :json
  payload = {
    sensor_id: params['sensor_id'],
    run_token: params['run_token'],
    data: {}
  }

  params['mode'] ||= UrlStats.LIST_MODE
  params['urls'].each { |u|
    payload[:data][u] = UrlStats.process(params['mode'], u)
  }
  payload.to_json
end
