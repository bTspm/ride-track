require 'spec_helper'

describe Api::UberClient do

  subject {Api::UberClient.new}

  describe '#initialize' do
    it 'should initialize client' do
      expect(subject).to be_kind_of Api::UberClient
    end
  end

  describe 'get_price_estimates' do
    it 'should return estimates' do
      allow_any_instance_of(
          Api::UberClient
      ).to receive(:_get).with(url: estimate_url, cache_key: 'uber-1+2+3+4') {'Estimates'}

      expect(
          subject.get_price_estimates(start_latitude: 1, start_longitude: 2, end_latitude: 3, end_longitude: 4)
      ).to eq 'Estimates'
    end
  end

  describe 'get_products' do
    it 'should return products' do
      allow_any_instance_of(
          Api::UberClient
      ).to receive(:_get).with(url: product_url, cache_key: 'uber-1+2') {'Products'}

      expect(subject.get_products(latitude: 1, longitude: 2)).to eq 'Products'
    end
  end

  private

  def estimate_url
    'v1.2/estimates/price?start_latitude=1&start_longitude=2&end_latitude=3&end_longitude=4'
  end

  def product_url
    'v1.2/products?latitude=1&longitude=2'
  end

end