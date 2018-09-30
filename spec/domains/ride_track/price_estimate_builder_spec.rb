require 'spec_helper'

describe Domains::RideTrack::PriceEstimateBuilder do

  let(:request) {double}
  let(:estimates) {build_estimates}
  let(:products) {build_products}

  subject {Domains::RideTrack::PriceEstimateBuilder.new(request: request)}

  describe 'initialize' do
    context 'with request' do
      it 'should return the properties' do
        result = subject
        expect(result).to be_kind_of Domains::RideTrack::PriceEstimateBuilder
        expect(result.request).to eq request
        expect(result.estimates).to eq []
        expect(result.errors).to eq []
        expect(result.products).to eq []
      end
    end

    context 'without request' do
      let(:request) {nil}
      it 'should raise an error' do
        expect {subject}.to raise_error ArgumentError
      end
    end
  end

  describe 'build' do
    context 'empty estimates' do
      it 'should return estimates empty' do
        subject.build
        expect(subject.estimates).to eq []
      end
    end

    context 'with estimates' do
      before :each do
        subject.estimates = estimates
        subject.products = products
      end
      it 'should sort the estimates' do
        subject.build
        expect(subject.estimates.map(&:id)).to match_array ['2', '1', '3']
      end

      it 'should assign products to estimates' do
        subject.build
        products = build_products.delete_if{|p| p.average_estimate.nil?}
        expect(subject.estimates.map(&:product).compact).to match_array products
      end
    end
  end

  private

  def build_estimates
    [OpenStruct.new(product_id: '1', product: nil, average_estimate: 200, id: '1'),
     OpenStruct.new(product_id: '2', product: nil, average_estimate: 100, id: '2'),
     OpenStruct.new(product_id: '3', product: nil, average_estimate: nil, id: '3')]
  end

  def build_products
    [OpenStruct.new(id: '1', average_estimate: 200),
     OpenStruct.new(id: '2', average_estimate: 100),
     OpenStruct.new(id: '4', average_estimate: nil)]
  end

end