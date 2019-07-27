require 'spec_helper'

describe Domains::Currency::Country do

  let(:name) { double }
  let(:code) { double }
  let(:alpha_code) { double }
  let(:currencyId) { double }
  let(:currencyName) { double }
  let(:currencySymbol) { double }

  let(:details) do
    {
      alpha3: alpha_code,
      id: code,
      name: name,
      currencySymbol: currencySymbol,
      currencyId: currencyId,
      currencyName: currencyName,
    }
  end

  let(:currency_details) do
    {
      code: currencyId,
      name: currencyName,
      symbol: currencySymbol
    }
  end

  subject(:country) { described_class.new(details) }

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance and properties' do
        expect(Domains::Currency::Currency).to receive(:new).with(currency_details) { 'Currency' }

        result = country
        expect(result).to be_kind_of Domains::Currency::Country
        expect(result.name).to eq name
        expect(result.code).to eq code
        expect(result.alpha_code).to eq alpha_code
        expect(result.currency).to eq 'Currency'
      end
    end
  end
end

