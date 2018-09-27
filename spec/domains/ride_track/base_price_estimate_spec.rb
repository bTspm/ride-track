require 'spec_helper'

describe Domains::RideTrack::BasePriceEstimate do

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

  describe '#distance' do
    it 'should raise an error duration' do
      expect {subject.distance}.to raise_error NotImplementedError
    end
  end

  describe '#distance_unit' do
    it 'should raise an error duration' do
      expect {subject.distance_unit}.to raise_error NotImplementedError
    end
  end

  describe '#distance_in_unit' do
    it 'should raise an error duration' do
      subject.product =  double(distance_unit: nil)
      expect {subject.distance_in_unit}.to raise_error NotImplementedError
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