require 'spec_helper'

describe Domains::RideTrack::Filters do

  let(:products) {build_products}
  subject {Domains::RideTrack::Filters.new(products: products)}

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance' do
        expect(subject).to be_kind_of Domains::RideTrack::Filters
      end
    end
  end

  describe '#capacities' do
    it 'should return capacities' do
      expect(subject.capacities).to include(2 => 2, 5 => 1)
    end
  end

  describe '#providers' do
    it 'should return providers' do
      expect(subject.providers).to include('uber' => 2, 'lyft' => 1)
    end
  end

  describe '#features' do
    it 'should return minimum_duration_in_minutes' do
      expect(subject.features).to include('no_cancellation'=>3, 'pay_cash'=>1, 'shared'=>1)
    end

    context 'no shared' do
      let(:products) {[OpenStruct.new(shared?: false)]}
      it 'should not contain shared' do
        expect(subject.features).not_to include 'shared'
      end
    end

    context 'no pay in cash' do
      let(:products) {[OpenStruct.new(pay_in_cash?: false)]}
      it 'should not contain pay_in_cash' do
        expect(subject.features).not_to include 'pay_in_cash'
      end
    end

    context 'no pay in cash' do
      let(:products) {[OpenStruct.new(cancellation_fee: 100)]}
      it 'should not contain cancellation_fee' do
        expect(subject.features).not_to include 'cancellation_fee'
      end
    end
  end

  private

  def build_products
    [OpenStruct.new(provider: 'uber', capacity: 2, shared?: true),
     OpenStruct.new(provider: 'uber', capacity: 2, pay_in_cash?: true),
     OpenStruct.new(provider: 'lyft', capacity: 5, cancellation_fee: 0)]
  end

end