require 'spec_helper'

describe Services do

  class DummyClass
    include Services
  end

  subject(:services) {DummyClass.new}

  describe '#currency_service' do
    subject { services.currency_service }

    it { is_expected.to be_kind_of Services::CurrencyService }
  end

  describe '#ride_track_service' do
    subject { services.ride_track_service }

    it { is_expected.to be_kind_of Services::RideTrackService }
  end
end
