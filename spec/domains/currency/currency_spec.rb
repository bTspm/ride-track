require 'spec_helper'

describe Domains::Currency::Currency do

  let(:code) { double }
  let(:name) { double }
  let(:symbol) { double }
  let(:countries) { double }

  let(:response) do
    {
      code: code,
      name: name,
      symbol: symbol
    }
  end

  subject(:currency) { described_class.new(response) }

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance and properties' do
        result = currency
        expect(result).to be_kind_of Domains::Currency::Currency
        expect(result.code).to eq code
        expect(result.name).to eq name
        expect(result.symbol).to eq symbol
      end
    end
  end

  describe '#countries' do
    let(:countries) { double }
    it 'should set and get countries' do
      currency.countries = countries
      expect(currency.countries).to eq countries
    end
  end
end

