require 'spec_helper'

describe Domains::RideTrack::FareDetails do

  let(:products) {build_products}
  let(:estimates) {build_estimates}
  subject {Domains::RideTrack::FareDetails.new(products: products, estimates: estimates)}

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance' do
        expect(subject).to be_kind_of Domains::RideTrack::FareDetails
      end
    end

    context 'products nil' do
      let(:products) {nil}
      it 'should raise an error when products are empty' do
        expect {subject}.to raise_error ArgumentError
      end
    end

    context 'estimates nil' do
      let(:estimates) {nil}
      it 'should raise an error when estimates are empty' do
        expect {subject}.to raise_error ArgumentError
      end
    end
  end

  describe '#distance_unit' do
    it 'should return distance_unit' do
      expect(subject.distance_unit).to eq 'Mile'
    end
  end

  describe '#minimum_distance' do
    it 'should return  minimum_distance' do
      expect(subject.minimum_distance).to eq 100
    end
  end

  describe '#minimum_duration_in_minutes' do
    it 'should return minimum_duration_in_minutes' do
      expect(subject.minimum_duration_in_minutes).to eq 200
    end
  end

  private

  def build_estimates
    [OpenStruct.new(distance_in_unit: 100, duration_in_minutes: 200), OpenStruct.new(distance_in_unit: 500, duration_in_minutes: 900)]
  end

  def build_products
    [OpenStruct.new(distance_unit: 'Mile'), OpenStruct.new(distance_unit:'Mile')]
  end

end