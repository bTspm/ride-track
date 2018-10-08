require 'spec_helper'

describe RideTrackController, type: :request do

  let(:service) {double}

  before :each do
    allow_any_instance_of(RideTrackController).to receive(:ride_track_service) {service}
  end

  describe 'GET home_page' do
    subject {get '/ride_track/home_page'}
    xit 'should render home_page' do
      subject
      assert_response :success
    end
  end

  describe 'GET price_estimate' do
    let(:address) {{latitude: 1, longitude: 2, city: 'A', state: 'B', postal_code: 'C', country: 'D'}}
    let(:params) {}

    before :each do
      allow(Domains::RideTrack::PriceEstimateRequest).to receive(:new) {double}
      allow(service).to receive(:get_price_estimates) {double(fare_details: 'Details')}
    end

    subject {get '/ride_track/price_estimate', params: {origin_details: address, destination_details: address, format: :js} }

    xit 'should render price_estimate' do
      subject
      assert_response :success
    end
  end

end
