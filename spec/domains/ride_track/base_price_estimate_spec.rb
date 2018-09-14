require 'spec_helper'

describe Domains::RideTrack::BasePriceEstimate do

  describe 'child class' do
    class DummyChild < Domains::RideTrack::BasePriceEstimate

      def initialize(high_estimate:, low_estimate:, surge_value:, duration:)
        @high_estimate = high_estimate
        @low_estimate = low_estimate
        @surge_value = surge_value
        @duration = duration
      end

      private

      attr_reader :high_estimate, :low_estimate, :surge_value, :duration
    end

    let(:high_estimate) {100}
    let(:low_estimate) {100}
    let(:surge_value) {100}
    let(:duration) {600}
    subject do DummyChild.new(high_estimate: high_estimate, low_estimate: low_estimate,
                              surge_value: surge_value, duration: duration)
    end

    describe '#average_estimate' do
      it 'should return avg cost when low, high estimate has values' do
        expect(subject.average_estimate).to eq 100
      end

      context 'high estimate less than 0' do
        let(:high_estimate) {0}
        it 'should raise an error provider' do
          expect(subject.average_estimate).to be_nil
        end
      end

      context 'high estimate less than 0' do
        let(:low_estimate) {0}
        it 'should raise an error provider' do
          expect(subject.average_estimate).to be_nil
        end
      end
    end

    describe 'surge?' do
      it 'should return true if value is greater than 1' do
        expect(subject.surge?).to eq true
      end

      context 'surge value < 1' do
        let(:surge_value) {0.5}
        it 'should return false if the value is less than 1' do
          expect(subject.surge?).to eq false
        end
      end
    end

    describe '#duration_in_minutes' do
      it 'should return the calculated surge value' do
        expect(subject.duration_in_minutes).to eq 10
      end
      context 'no duration' do
        let(:duration) {nil}
        it 'should return the value as 0' do
          expect(subject.duration_in_minutes).to eq 0
        end
      end
    end

  end

  subject {::Domains::RideTrack::BasePriceEstimate.new}

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

  describe '#surge_value' do
    it 'should raise an error surge_value' do
      expect {subject.surge_value}.to raise_error NotImplementedError
    end
  end

  describe '#surge?' do
    it 'should raise an error surge?' do
      expect {subject.surge?}.to raise_error NotImplementedError
    end
  end

  describe '#duration' do
    it 'should raise an error duration' do
      expect {subject.duration}.to raise_error NotImplementedError
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