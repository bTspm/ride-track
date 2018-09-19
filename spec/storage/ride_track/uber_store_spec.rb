require 'spec_helper'

describe Storage::RideTrack::UberStore do

  let(:store) {Storage::RideTrack::UberStore.new}
  let(:client) {double}
  let(:address) {double(latitude: 1, longitude: 0)}
  let(:response) {double(success: true, body: {prices: ['price'], products: ['product']})}

  before :each do
    allow(Api::UberClient).to receive(:new) {client}
    allow(client).to receive(:get_price_estimates) {response}
    allow(client).to receive(:get_products) {response}
    allow(Domains::RideTrack::Uber::PriceEstimate).to receive(:new) {'Estimate'}
    allow(Domains::RideTrack::Uber::Product).to receive(:new) {'Product'}
  end

  describe '#get_price_estimates' do
    let(:request) {double(origin: address, destination: address)}
    subject {store.get_price_estimates(request: request)}

    context 'request nil' do
      let(:request) {nil}
      it 'should raise an error' do
        expect {subject}.to raise_error ArgumentError
      end
    end

    context 'response - success' do
      it 'should return estimates' do
        expect(subject).to match_array ['Estimate']
      end
    end

    context 'response - error' do
      let(:response) {double(success: false, body: {message: nil})}
      it 'should raise an error response is not success' do
        expect {subject}.to raise_error Exceptions::RideTrack::ApiError
      end
    end
  end

  describe '#get_products' do
    let(:request) {address}
    subject {store.get_products(request: request)}

    context 'request nil' do
      let(:request) {nil}
      it 'should raise an error' do
        expect {subject}.to raise_error ArgumentError
      end
    end

    context 'response - success' do
      it 'should return products' do
        expect(subject).to match_array ['Product']
      end
    end

    context 'response - error' do
      let(:response) {double(success: false, body: {message: nil})}
      it 'should raise an error response is not success' do
        expect {subject}.to raise_error Exceptions::RideTrack::ApiError
      end
    end
  end

end