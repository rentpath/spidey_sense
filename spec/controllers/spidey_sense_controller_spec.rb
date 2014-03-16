require 'spec_helper'

describe Motorurl::SensorsController do
  routes { Motorurl::Engine.routes }

  body = {
        'sha1' => '8ece61d2d42e578e86d9f95ad063cf36eb8e774d',
    'seed_url' => 'http://www.example.com',
       'stats' => {
          'canonical' => 'http://example.com/page.html',
        'description' => 'Meta description',
            'headers' => {
            'content-type' => 'text/html'
            },
               'urls' => [
                {
                'link_text' => 'Reference #1',
                      'url' => 'http://example.com/ref1.html',
                     'sha1' => 'd6cf76b6e96bd12a819433f14a9dc334d590a3e6'
                },
                {
                'link_text' => 'Reference #2',
                      'url' => 'http://example.com/ref2.html',
                     'sha1' => 'c4a4742b6738ad14775a34ca5bf28aae2b03d085'
                },
                {
                'link_text' => 'Fully-qualfied link',
                      'url' => 'http://www.example.com/ref3.html',
                     'sha1' => '925311375fe3e21c749950d76b626dded4500fb7'
                }
              ]
        },
      'status' => 200
  }
  url = 'http://www.example.com'

  let!(:password) { generate_one_time_password Motorurl.configuration.shared_secret }
  let!(:url)      { url }
  let!(:params)   { { url: { url: url }, password: password } }

  before(:all) do
    Motorurl.configure { |c| c.sensor_job_class = PageInformationJob }
  end

  it 'routes incoming URL to PageInformationJob' do
    post :create, '/sensor', params, format: :json
    expect(response).to be_ok
    expect(PageInformationJob).to have(1).enqueued.jobs
  end

  it_behaves_like 'a mocked connection', :get, 'perform_spec1.html', url do
    it 'generates a report' do
      Sidekiq::Testing.inline! do
        stub_request(:post, 'http://localhost:3000/data')
        post :create, '/sensor', params, format: :json
      end
    end
  end
end
