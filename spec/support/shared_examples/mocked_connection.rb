shared_examples 'a mocked connection' do |method, fixture, url|
  before(:all) do
    WebMock.disable_net_connect!
    contents = read_fixture fixture
    headers   = { 'Content-Type' => 'text/html' }
    stub_request(method, url).to_return(status: 200, body: contents, headers: headers)
  end
end
