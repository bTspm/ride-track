require 'spec_helper'

describe Domains::Currency::HistoryResponse do

  let(:date) { double('date') }
  let(:fr) { double('fr') }
  let(:history) { double('history') }
  let(:to) { double('to') }
  let(:rate) { double('rate') }
  let(:val) do
    hash = Hash.new
    hash[date] = rate
    hash
  end

  let(:details) do
    {
      fr: fr,
      to: to,
      val: val
    }
  end

  subject(:history_response) { described_class.new(details) }

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance and properties' do
        expect(Domains::Currency::History).to receive(:new).with({date: date, rate: rate}) { history }

        result = history_response
        expect(result).to be_kind_of Domains::Currency::HistoryResponse
        expect(result.from).to eq fr
        expect(result.to).to eq to
        expect(result.histories).to match_array [history]
      end
    end

    context 'no histories' do
      let(:val) { [] }
      subject { history_response.histories }
      it { is_expected.to match_array [] }
    end
  end
end

