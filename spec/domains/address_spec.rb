require 'spec_helper'

describe Domains::Address do

  let(:city) { double }
  let(:country_code) { double }
  let(:country_name) { double }
  let(:currency_code) { double }
  let(:latitude) { double }
  let(:longitude) { double }
  let(:state_code) { double }
  let(:state_name) { double }
  let(:time_zone) { double }
  let(:zip_code) { double }

  let(:details) do
    {
      city: city,
      country_code: country_code,
      country_name: country_name,
      currency_code: currency_code,
      latitude: latitude,
      longitude: longitude,
      state_code: state_code,
      state_name: state_name,
      time_zone: time_zone,
      zip_code: zip_code,
    }
  end

  subject(:address) { described_class.new(details: details) }

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance and properties' do
        result = address
        expect(result).to be_kind_of Domains::Address
        expect(result.city).to eq city
        expect(result.country_code).to eq country_code
        expect(result.country_name).to eq country_name
        expect(result.currency_code).to eq currency_code
        expect(result.latitude).to eq latitude
        expect(result.longitude).to eq longitude
        expect(result.state_code).to eq state_code
        expect(result.state_name).to eq state_name
        expect(result.time_zone).to eq time_zone
        expect(result.zip_code).to eq zip_code
      end
    end
  end

  describe 'is_us?' do
    subject { address.is_us? }
    context 'country_code - nil' do
      let(:country_code) { nil }
      it { is_expected.to eq false }
    end

    context 'country_code - ABC' do
      let(:country_code) { 'ABC' }
      it { is_expected.to eq false }
    end

    context 'country_code - US' do
      let(:country_code) { 'US' }
      it { is_expected.to eq true }
    end
  end
end

