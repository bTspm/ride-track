require 'spec_helper'

describe Domains::Address do

  let(:details) {{latitude: 'lat', longitude: 'long'}}
  subject {Domains::Address.new(details: details)}

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance and properties' do
        result = subject
        expect(result).to be_kind_of Domains::Address
        expect(result.latitude).to eq 'lat'
        expect(result.longitude).to eq 'long'
      end
    end
  end

end