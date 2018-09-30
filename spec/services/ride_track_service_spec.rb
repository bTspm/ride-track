require 'spec_helper'

describe Services::RideTrackService do

  let(:ins) {Services::RideTrackService.new}
  let(:lyft_storage) {double}
  let(:uber_storage) {double}

  let(:est_builder) {build_est_builder}
  let(:products) {['Products']}
  let(:estimates) {['Estimates']}

  before :each do
    allow(Domains::RideTrack::PriceEstimateBuilder).to receive(:new) {est_builder}

    allow(ins).to receive(:uber_storage) {uber_storage}
    allow(ins).to receive(:lyft_storage) {lyft_storage}

    allow(uber_storage).to receive(:get_products) {products}
    allow(uber_storage).to receive(:get_price_estimates) {estimates}

    allow(lyft_storage).to receive(:get_products) {products}
    allow(lyft_storage).to receive(:get_price_estimates) {estimates}
  end

  describe 'get_price_estimates' do
    subject {ins.get_price_estimates(request: 'a')}
    context 'without errors' do
      it 'should return builder with estimates' do
        expect(subject).to eq est_builder
      end
    end

    context 'with errors' do
      it 'should return builder with errors' do
        exception = Exceptions::RideTrack::ApiError.new(message: 'test error')
        allow(uber_storage).to receive(:get_products).and_raise exception

        expect(subject).to eq est_builder
        expect(subject.errors).to match_array ['test error']
      end
    end
  end

  private

  def build_est_builder
    OpenStruct.new(
        estimates: [],
        errors: [],
        products: [],
        build: 'Estimates Built',
        request: OpenStruct.new(origin: 'a'),

    )
  end
end