require 'spec_helper'

describe Domains::RideTrack::BasePriceEstimate do

  describe 'child class' do
    class DummyChild < Domains::RideTrack::BasePriceEstimate
      attr_reader :high_estimate, :low_estimate, :provider, :currency_code

      def initialize(high_estimate:, low_estimate:, currency_code:, provider:)
        @high_estimate = high_estimate
        @low_estimate = low_estimate
        @provider = provider
        @currency_code = currency_code
      end
    end

    describe '#average_estimate' do
      let(:high_estimate) {100}
      let(:low_estimate) {100}
      let(:provider) {'Test'}
      let(:currency_code) {'USD'}
      subject {DummyChild.new(
          high_estimate: high_estimate, low_estimate: low_estimate, provider: provider, currency_code: currency_code
      )}

      it 'should return properties' do
        expect(subject.currency_code).to eq 'USD'
        expect(subject.provider).to eq 'Test'
      end

      it 'should return avg cost when low, high estimate has values' do
        expect(subject.average_estimate).to eq 100
      end

      context 'high estimate nil' do
        let(:high_estimate) {nil}
        it 'should raise an error provider' do
          expect(subject.average_estimate).to eq ''
        end
      end

      context 'low estimate nil' do
        let(:low_estimate) {nil}
        it 'should raise an error provider' do
          expect(subject.average_estimate).to eq ''
        end
      end

    end
  end

  subject {::Domains::RideTrack::BasePriceEstimate.new}

  describe '#provider' do
    it 'should raise an error provider' do
      expect {subject.provider}.to raise_error NotImplementedError
    end
  end

  describe '#currency_code' do
    it 'should raise an error currency_code' do
      expect {subject.currency_code}.to raise_error NotImplementedError
    end
  end

  describe '#high_estimate' do
    it 'should raise an error high_estimate' do
      expect {subject.high_estimate}.to raise_error NotImplementedError
    end
  end

  describe '#low_estimate' do
    it 'should raise an error low_estimate' do
      expect {subject.low_estimate}.to raise_error NotImplementedError
    end
  end

  describe '#average_estimate' do
    it 'should raise an error average_estimate' do
      expect {subject.average_estimate}.to raise_error NotImplementedError
    end
  end

  describe '#product' do
    it 'should assign product and return' do
      expect(subject.product).to be_nil

      subject.product = 1
      expect(subject.product).to eq 1
    end
  end

end