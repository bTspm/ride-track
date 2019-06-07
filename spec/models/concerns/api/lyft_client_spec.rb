require 'spec_helper'

describe Api::LyftClient do

  subject {Api::LyftClient.new}

  before :each do
    allow_any_instance_of(Api::Client).to receive(:build_connection) {double}
    allow_any_instance_of(Api::Client).to receive(:post) {double(body: {})}
  end

  describe '#initialize' do
    it 'should initialize client' do
      expect(subject).to be_kind_of Api::LyftClient
    end
  end

  describe 'get_price_estimates' do
    it 'should return estimates' do
      allow_any_instance_of(
          Api::LyftClient
      ).to receive(:get).with(url: estimate_url, cache_key: 'lyft-1+2+3+4') {'Estimates'}

      expect(
          subject.get_price_estimates(start_latitude: 1, start_longitude: 2, end_latitude: 3, end_longitude: 4)
      ).to eq 'Estimates'
    end
  end

  describe 'get_products' do
    it 'should return products' do
      allow_any_instance_of(
          Api::LyftClient
      ).to receive(:get).with(url: product_url, cache_key: 'lyft-1+2') {'Products'}

      expect(subject.get_products(latitude: 1, longitude: 2)).to eq 'Products'
    end
  end

  private

  def estimate_url
    'v1/cost?start_lat=1&start_lng=2&end_lat=3&end_lng=4'
  end

  def product_url
    'v1/ridetypes?lat=1&lng=2'
  end

end