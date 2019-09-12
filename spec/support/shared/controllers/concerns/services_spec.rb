require 'spec_helper'

shared_examples_for 'controllers_concerns_services_spec' do

  let(:service) { described_class.new }

  describe '#currency_service' do
    subject { service.currency_service }
    it { is_expected.to be_kind_of Services::CurrencyService }
  end

  describe '#ip_service' do
    subject { service.ip_service }
    it { is_expected.to be_kind_of Services::IpService }
  end

  describe '#ride_track_service' do
    subject { service.ride_track_service }
    it { is_expected.to be_kind_of Services::RideTrackService }
  end
end

