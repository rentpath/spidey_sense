require 'spec_helper'

describe Motorurl::SensorsController do
  routes { Motorurl::Engine.routes }

  let!(:password) { generate_one_time_password Motorurl.configuration.shared_secret }
  let!(:url)      { 'http://www.example.org' }
  let!(:params)   { { url: { url: url }, password: password } }

  it 'Routes job to SpideySense' do
    Motorurl.configure { |c| c.sensor_job_class = PageInformationJob }
    post :create, '/sensor', params, format: :json
    expect(response).to be_ok
    expect(PageInformationJob).to have(1).enqueued.jobs
  end
end
