require 'spec_helper'

describe 'Motorurl Routes' do
  routes { Motorurl::Engine.routes }

  it 'routes to engine create' do
    expect({ post: '/sensor' })
      .to route_to(controller: 'motorurl/sensors', action: 'create')
  end
end
