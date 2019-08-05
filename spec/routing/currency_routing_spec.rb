require 'spec_helper'

RSpec.describe 'currency routing', :aggregate_failures, type: :routing do

  it 'routes currencies' do
    expect(get: '/currencies/home').to route_to(controller: 'currencies', action: 'home')
    expect(get: '/currencies/convert').to route_to(controller: 'currencies', action: 'convert')
    expect(get: '/currencies/exchange_rate').to route_to(controller: 'currencies', action: 'exchange_rate')
    expect(get: '/currencies/list').to route_to(controller: 'currencies', action: 'list')
  end

end

