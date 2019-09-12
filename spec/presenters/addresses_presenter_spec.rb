require 'spec_helper'

describe Presenters::AddressesPresenter do

  let(:view_context) { ActionController::Base.new }

  let(:address) do
    double(
      'address',
      city: city,
      country_code: country_code,
      latitude: latitude,
      longitude: longitude,
      state_code: state_code,
      time_zone: time_zone,
      zip_code: zip_code,
      )
  end
  let(:city) { 'city' }
  let(:country_code) { 'country_code' }
  let(:latitude) { 'latitude' }
  let(:longitude) { 'longitude' }
  let(:state_code) { 'state_code' }
  let(:time_zone) { 'America/New_York' }
  let(:zip_code) { 'zip_code' }

  describe '.scalar' do
    subject(:scalar) { described_class.present(address, view_context) }

    describe '#coordinates' do
      subject { scalar.coordinates }

      it { is_expected.to eq "#{latitude}, #{longitude}" }
    end

    describe '#local_time' do
      let(:time) { Time.new(2019) }

      subject { scalar.local_time }
      it 'should return local time' do
        expect(Time).to receive(:now) { time }
        expect(subject).to eq '1st Jan 19, 12:00 AM'
      end
    end

    describe '#location' do
      subject { scalar.location }
      context 'with zip_code' do
        it { is_expected.to eq "#{zip_code}, #{city}" }
      end

      context 'without zip_code' do
        let(:zip_code) { nil }
        it { is_expected.to eq city }
      end
    end

    describe '#map_location_params' do
      let(:result) do
        {
          coordinates: { lat: latitude, lng: longitude },
          selector: 'ip-location-map-container',
          title: "#{city}, #{state_code}, #{country_code}"
        }.with_indifferent_access
      end
      subject(:parsed_params) { JSON.parse(scalar.map_location_params).with_indifferent_access }
      it { is_expected.to include result }
    end
  end
end

