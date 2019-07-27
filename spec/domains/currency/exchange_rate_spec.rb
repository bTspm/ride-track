require 'spec_helper'

describe Domains::Currency::ExchangeRate do

  let(:fr) { double }
  let(:to) { double }
  let(:val) { double }

  let(:response) do
    {
      fr: fr,
      to: to,
      val: val
    }
  end

  subject(:exchange_rate) { described_class.new(response) }

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance and properties' do
        result = exchange_rate
        expect(result).to be_kind_of Domains::Currency::ExchangeRate
        expect(result.from).to eq fr
        expect(result.to).to eq to
        expect(result.rate).to eq val
      end
    end
  end

  describe '#from_currency' do
    let(:from_currency) { double }
    it 'should set and get from_currency' do
      exchange_rate.from_currency = from_currency
      expect(exchange_rate.from_currency).to eq from_currency
    end
  end

  describe '#to_currency' do
    let(:to_currency) { double }
    it 'should set and get to_currency' do
      exchange_rate.to_currency = to_currency
      expect(exchange_rate.to_currency).to eq to_currency
    end
  end
end

