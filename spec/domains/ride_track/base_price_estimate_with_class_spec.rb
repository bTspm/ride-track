require 'spec_helper'

describe Domains::RideTrack::BasePriceEstimate do
  describe 'child class' do
    class DummyChild < Domains::RideTrack::BasePriceEstimate

      def initialize(high_estimate:, low_estimate:, surge_value:, distance:, distance_unit:)
        @high_estimate = high_estimate
        @low_estimate = low_estimate
        @surge_value = surge_value
        @distance = distance
        @distance_unit = distance_unit
      end

      private

      attr_reader :high_estimate, :low_estimate, :surge_value, :distance, :distance_unit
    end

    let(:high_estimate) {100}
    let(:low_estimate) {100}
    let(:surge_value) {100}
    let(:distance) {600}
    let(:distance_unit) {Constants::MILE}

    subject do
      DummyChild.new(
          high_estimate: high_estimate,
          low_estimate: low_estimate,
          surge_value: surge_value,
          distance: distance,
          distance_unit: distance_unit
      )
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

    describe '#distance_in_unit' do
      before :each do
        allow_any_instance_of(DummyChild).to receive(:product_distance_unit) {Constants::MILE}
      end

      context 'Product and Estimate Units same' do
        it 'should return the distance un-calculated' do
          expect(subject.distance_in_unit).to eq 600
        end
      end

      context 'Product Unit - Mile and Estimate Unit - KM' do
        let(:distance_unit) {Constants::KM}
        it 'should convert and return the value to Mile' do
          expect(subject.distance_in_unit).to eq 360.0
        end
      end

      context 'Product Unit - KM and Estimate Unit - Mile' do
        it 'should convert and return the value to KMs' do
          allow_any_instance_of(DummyChild).to receive(:product_distance_unit) {Constants::KM}
          expect(subject.distance_in_unit).to eq 960.0
        end
      end

      context 'invalid unit' do
        let(:distance_unit) {nil}
        it 'should raise an error' do
          expect {subject.distance_in_unit}.to raise_error Exceptions::AppExceptions::NoSelectionError
        end
      end
    end

  end
end

