require 'spec_helper'

describe Domains::Currency::History do

  let(:date) { '2019-01-01' }
  let(:rate) { double }

  let(:response) do
    {
      date: date,
      rate: rate
    }
  end

  subject(:history) { described_class.new(response) }

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance and properties' do
        result = history
        expect(result).to be_kind_of Domains::Currency::History
        expect(result.date.to_s).to eq date
        expect(result.rate).to eq rate
      end
    end
  end
end

